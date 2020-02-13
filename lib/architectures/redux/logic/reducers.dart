import 'package:redux/redux.dart';

import 'actions.dart';

import 'state.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    registrationState: registrationReducer(state.registrationState, action),
    roomListState: state.roomListState,
  );
}

final registrationReducer = combineReducers<RegistrationState>([
  TypedReducer<RegistrationState, ValidateName>(_validateName),
  TypedReducer<RegistrationState, Register>(_login),
  TypedReducer<RegistrationState, RegisteredSuccessfully>(_loginSuccess),
  TypedReducer<RegistrationState, RegisteredFailed>(_loginFailed),
]);

RegistrationState _validateName(RegistrationState state, ValidateName action) {
  return state.when(
    (name, validationError) =>
        RegistrationState(name: action.name, validationError: _validate(action.name)),
    loading: (_) => state,
  );
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
  return RegistrationState.loading(name: state.name);
}

RegistrationState _loginSuccess(RegistrationState state, RegisteredSuccessfully action) {
  // TODO: ログイン状態に変更させるとかする
  return RegistrationState(name: state.name);
}

RegistrationState _loginFailed(RegistrationState state, RegisteredFailed action) {
  // TODO: エラー処理させるとかする？
  return RegistrationState(name: state.name);
}
