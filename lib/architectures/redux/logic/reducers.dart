import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    registrationState: registrationReducer(state.registrationState, action),
    roomListState: roomListReducer(state.roomListState, action),
    roomInsideState: roomInsideReducer(state.roomInsideState, action),
  );
}

final registrationReducer = combineReducers<RegistrationState>([
  TypedReducer<RegistrationState, ValidateName>(_validateName),
  TypedReducer<RegistrationState, Register>(_login),
  TypedReducer<RegistrationState, RegisteredSuccessfully>(_loginSuccess),
  TypedReducer<RegistrationState, RegisteredFailed>(_loginFailed),
]);

RegistrationState _validateName(RegistrationState state, ValidateName action) {
  if (state.loading) {
    return state;
  }
  final validationResult = _validate(action.name);
  return state.copyWith(
      name: action.name,
      validationError: validationResult ?? "",
      valid: validationResult == null);
}

const maxNameLength = 40;

String _validate(String name) {
  if (name.isEmpty) {
    return "名前を入力してください";
  }
  if (name.length > maxNameLength) {
    return "名前は${maxNameLength}文字以内である必要があります";
  }
  if (name.contains("\n")) {
    return "名前に改行を含めることはできません";
  }
  return null;
}

RegistrationState _login(RegistrationState state, Register action) {
  return state.copyWith(loading: true);
}

RegistrationState _loginSuccess(
    RegistrationState state, RegisteredSuccessfully action) {
  // TODO: ログイン状態に変更させるとかする
  return state.copyWith(loading: false);
}

RegistrationState _loginFailed(
    RegistrationState state, RegisteredFailed action) {
  // TODO: エラー処理させるとかする？
  return state.copyWith(loading: false);
}

final roomListReducer = combineReducers<RoomListState>([
  TypedReducer<RoomListState, RoomListSubscribingStarted>(
      _roomListSubscribingStarted),
  TypedReducer<RoomListState, RoomListUpdated>(_roomListUpdated),
]);

RoomListState _roomListSubscribingStarted(
    RoomListState state, RoomListSubscribingStarted action) {
  return state.copyWith(subscription: action.subscription);
}

RoomListState _roomListUpdated(RoomListState state, RoomListUpdated action) {
  return state.copyWith(rooms: action.rooms);
}

final roomInsideReducer = combineReducers<RoomInsideState>([
  TypedReducer<RoomInsideState, StartSubscribingRoom>(_startSubscribingRoom),
  TypedReducer<RoomInsideState, UnsubscribeRoom>(_unsubscribeRoom),
  TypedReducer<RoomInsideState, TranscriptSubscriptionStarted>(
      _transcriptSubscriptionStarted),
  TypedReducer<RoomInsideState, TranscriptUpdated>(_transcriptUpdated),
  TypedReducer<RoomInsideState, UpdateDraft>(_updateDraft),
  TypedReducer<RoomInsideState, SendingMessage>(_sendingMessage),
  TypedReducer<RoomInsideState, SendingMessageDone>(_sendingMessageDone),
]);

RoomInsideState _startSubscribingRoom(
    RoomInsideState state, StartSubscribingRoom action) {
  return state.copyWith(roomId: action.roomId);
}

RoomInsideState _unsubscribeRoom(
    RoomInsideState state, UnsubscribeRoom action) {
  state.subscription.cancel();
  return state.copyWith(subscription: null, transcripts: <Transcript>[]);
}

RoomInsideState _transcriptSubscriptionStarted(
    RoomInsideState state, TranscriptSubscriptionStarted action) {
  return state.copyWith(subscription: action.subscription);
}

RoomInsideState _transcriptUpdated(
    RoomInsideState state, TranscriptUpdated action) {
  return state.copyWith(transcripts: action.transcripts);
}

RoomInsideState _updateDraft(RoomInsideState state, UpdateDraft action) {
  return state.copyWith(
      draft: action.body, valid: _validateMessage(action.body));
}

const maxBodyLength = 1000;

bool _validateMessage(String message) {
  return message.isNotEmpty && (message.length <= maxBodyLength);
}

RoomInsideState _sendingMessage(RoomInsideState state, SendingMessage action) {
  return state.copyWith(sending: true);
}

RoomInsideState _sendingMessageDone(
    RoomInsideState state, SendingMessageDone action) {
  return state.copyWith(sending: false, draft: "", valid: false);
}
