import 'dart:async';

import 'package:flutter_architecture_samples/domain/member.dart';
import 'package:flutter_architecture_samples/domain/message.dart';
import 'package:flutter_architecture_samples/repository/repositories.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class LoginActionTryLogin {}

class LoginActionLoggingIn {}

class LoginActionDone {
  final String loginToken;

  LoginActionDone(this.loginToken);
}

abstract class LoginState {
  const LoginState();
}

class LoginStateNotLoggedIn extends LoginState {
  const LoginStateNotLoggedIn();
}

class LoginStateLoggingIn extends LoginState {
  const LoginStateLoggingIn();
}

class LoginStateLoggedIn extends LoginState {
  final String loginToken;
  final MemberState memberState;
  final MessageState messageState;

  const LoginStateLoggedIn(this.loginToken,
      [this.memberState = const MemberStateLoaded(), this.messageState = const MessageStateSubscribing()]);

  LoginStateLoggedIn edit({MemberState memberState, MessageState messageState}) {
    if (memberState != null) {
      return LoginStateLoggedIn(loginToken, memberState, this.messageState);
    }
    if (messageState != null) {
      return LoginStateLoggedIn(loginToken, this.memberState, messageState);
    }
    return this;
  }
}

LoginState _reducerLoginTryLogin(LoginState state, dynamic action) {
  return state;
}

LoginState _reducerLoginLoggingIn(LoginState state, dynamic action) {
  if (state is LoginStateNotLoggedIn && action is LoginActionLoggingIn) {
    return const LoginStateLoggingIn();
  }
  return state;
}

LoginState _reducerLoginDone(LoginState state, dynamic action) {
  if (state is LoginStateLoggingIn && action is LoginActionDone) {
    return LoginStateLoggedIn(action.loginToken);
  }
  return state;
}

LoginState Function(LoginState, dynamic) needsLogin(
    LoginStateLoggedIn Function(LoginStateLoggedIn state, dynamic action)
        reducer) {
  return (LoginState state, dynamic action) {
    if (state is LoginStateLoggedIn) {
      return reducer(state, action);
    }
    return state;
  };
}

LoginState Function(LoginState, dynamic) needsLoginTypedAction<A>(
    LoginStateLoggedIn Function(LoginStateLoggedIn state, A action) reducer) {
  return needsLogin((state, action) {
    if (action is A) {
      return reducer(state, action);
    }
    return state;
  });
}

final loginReducer = combineReducers<LoginState>([
  _reducerLoginTryLogin,
  _reducerLoginLoggingIn,
  _reducerLoginDone,
]);

class LoginEpic extends EpicClass<LoginState> {
  final AccountRepository _repository;

  LoginEpic(this._repository) : assert(_repository != null);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<LoginState> store) {
    return Observable(actions)
        .whereType<LoginActionTryLogin>()
        .flatMap((_) async* {
      yield LoginActionLoggingIn();

      final token = await _repository.login();
      yield LoginActionDone(token);
    });
  }
}
