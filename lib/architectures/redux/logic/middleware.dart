import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

List<Middleware<AppState>> generateMiddleware(
    AccountRepository account, RoomRepository room) {
  return [
    TypedMiddleware<AppState, Register>(AccountCreateMiddleware(account)),
    TypedMiddleware<AppState, StartSubscribingRoomList>(
        RoomListSubscribeMiddleware(room, account)),
    TypedMiddleware<AppState, StartSubscribingRoom>(
        TranscriptSubscribingMiddleware(room)),
    TypedMiddleware<AppState, SendMessage>(
        SendMessageMiddleware(room, account)),
  ];
}

class AccountCreateMiddleware {
  final AccountRepository repository;

  AccountCreateMiddleware(this.repository);

  void call(Store<AppState> store, action, NextDispatcher next) {
    final reg = store.state.registrationState;
    repository.createAccount(name: reg.name).then((uid) {
      next(RegisteredSuccessfully());
    }).catchError((_) {
      next(RegisteredFailed());
    });

    next(action);
  }
}

class RoomListSubscribeMiddleware {
  final RoomRepository roomRepository;
  final AccountRepository accountRepository;

  RoomListSubscribeMiddleware(this.roomRepository, this.accountRepository);

  void call(Store<AppState> store, action, NextDispatcher next) {
    accountRepository.currentUid().then((uid) {
      final subscription =
          roomRepository.subscribeRooms(uid: uid).listen((rooms) {
        next(RoomListUpdated(rooms));
      });
      next(RoomListSubscribingStarted(subscription));
    });

    next(action);
  }
}

class TranscriptSubscribingMiddleware {
  final RoomRepository roomRepository;

  TranscriptSubscribingMiddleware(this.roomRepository);

  void call(
      Store<AppState> store, StartSubscribingRoom action, NextDispatcher next) {
    final subscription = roomRepository
        .subscribeTranscripts(roomId: action.roomId)
        .listen((transcripts) {
      next(TranscriptUpdated(transcripts));
    });

    next(action);
    next(TranscriptSubscriptionStarted(subscription));
  }
}

class SendMessageMiddleware {
  final RoomRepository roomRepository;
  final AccountRepository accountRepository;

  SendMessageMiddleware(this.roomRepository, this.accountRepository);

  void call(Store<AppState> store, SendMessage action, NextDispatcher next) {
    accountRepository.currentUid().then((uid) {
      var insideState = store.state.roomInsideState;
      return roomRepository.postTranscript(
        uid: uid,
        content: insideState.draft,
        roodId: insideState.roomId,
      );
    }).then((_) {
      next(SendingMessageDone());
    });

    next(action);
    next(SendingMessage());
  }
}
