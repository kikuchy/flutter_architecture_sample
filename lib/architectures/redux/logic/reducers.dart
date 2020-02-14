import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    registrationState: registrationReducer(state.registrationState, action),
    roomListState: roomListReducer(state.roomListState, action),
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
  return RegistrationState(name: state.name, loading: true);
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
  TypedReducer<RoomListState, StartSubscribingRoomList>(
      _startSubscribingRoomList),
  TypedReducer<RoomListState, RoomListSubscribingStarted>(
      _roomListSubscribingStarted),
  TypedReducer<RoomListState, RoomListUpdated>(_roomListUpdated),
]);

RoomListState _startSubscribingRoomList(
    RoomListState state, StartSubscribingRoomList action) {
  return state;
}

RoomListState _roomListSubscribingStarted(
    RoomListState state, RoomListSubscribingStarted action) {
  // TODO: subscriptionってどこに持たせるべき？
  return state;
}

RoomListState _roomListUpdated(RoomListState state, RoomListUpdated action) {
  return state.copyWith(rooms: action.rooms);
}
