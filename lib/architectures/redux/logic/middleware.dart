import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

List<Middleware<AppState>> generateMiddleware(AccountRepository account) {
  return [
    TypedMiddleware<AppState, Register>(AccountCreateMiddleware(account)),
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
