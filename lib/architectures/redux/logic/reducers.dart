import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

import 'state.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, ValidateName>(_validateName),
  TypedReducer<AppState, Login>(_login),
  TypedReducer<AppState, LoggedInSuccessfully>(_loginSuccess),
  TypedReducer<AppState, LoggedInFailed>(_loginFailed),
]);

AppState _validateName(AppState state, ValidateName action) {
  return state.when(
    (name, validationError) =>
        AppState(name: action.name, validationError: _validate(action.name)),
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

AppState _login(AppState state, Login action) {
  return AppState.loading(name: state.name);
}

AppState _loginSuccess(AppState state, LoggedInSuccessfully action) {
  // TODO: ログイン状態に変更させるとかする
  return AppState(name: state.name);
}

AppState _loginFailed(AppState state, LoggedInFailed action) {
  // TODO: エラー処理させるとかする？
  return AppState(name: state.name);
}

List<Middleware<AppState>> generateMiddleware(AccountRepository account) {
  return [
    TypedMiddleware<AppState, Login>(AccountCreateMiddleware(account)),
  ];
}

class AccountCreateMiddleware {
  final AccountRepository repository;

  AccountCreateMiddleware(this.repository);

  void call(Store<AppState> store, action, NextDispatcher next) {
    repository.createAccount(name: store.state.name).then((uid) {
      next(LoggedInSuccessfully());
    }).catchError((_) {
      next(LoggedInFailed());
    });

    next(action);
  }
}
