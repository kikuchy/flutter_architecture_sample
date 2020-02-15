import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:rxdart/rxdart.dart';

/// チャットルームの発言履歴を司るBLoC
class TranscriptHistoryBloc implements Bloc {
  final String roomId;
  final RoomRepository repository;

  Stream<List<Transcript>> transcripts;

  TranscriptHistoryBloc(this.roomId, this.repository) {
    transcripts = repository.subscribeTranscripts(roomId: roomId);
  }

  @override
  void dispose() {}
}

enum MessageSendResult {
  success,
  failure,
}

/// 発言のバリデーションと投稿を司るBLoC
class MessageBloc implements Bloc {
  static const maxBodyLength = 1000;

  BehaviorSubject<String> _body = BehaviorSubject.seeded("");

  StreamSink<String> get body => _body;

  Stream<bool> get valid => _body.stream.map(_validate);

  StreamController<Null> _send = StreamController.broadcast();

  StreamSink<Null> get send => _send;

  BehaviorSubject<bool> _sending = BehaviorSubject.seeded(false);

  Stream<bool> get sending => _sending;

  StreamController<MessageSendResult> _result = StreamController.broadcast();

  Stream<MessageSendResult> get result => _result.stream;

  final AccountRepository accountRepository;
  final RoomRepository roomRepository;
  final String roomId;

  MessageBloc({
    @required this.roomId,
    @required this.accountRepository,
    @required this.roomRepository,
  }) {
    _send.stream.map((_) => _body.value).listen((body) async {
      _sending.add(true);
      final uid = await accountRepository.currentUid();
      await roomRepository.postTranscript(
          roodId: roomId, uid: uid, content: body);
      _body.value = "";
      _sending.add(false);
      _result.add(MessageSendResult.success);
    }, onError: (err) {
      _sending.add(false);
      _result.add(MessageSendResult.failure);
    });
  }

  bool _validate(String message) {
    return message.isNotEmpty && (message.length <= maxBodyLength);
  }

  @override
  void dispose() {
    _result.close();
    _sending.close();
    _send.close();
    _body.close();
  }
}
