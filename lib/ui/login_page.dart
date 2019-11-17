import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/domain/login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _LoginViewModel {
  final Store<LoginState> _store;

  _LoginViewModel(this._store);

  bool get isLoggingIn => _store.state is LoginStateLoggingIn;

  void login() {
    _store.dispatch(LoginActionTryLogin());
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StoreConnector<LoginState, _LoginViewModel>(
          converter: (store) => _LoginViewModel(store),
          builder: (context, vm) => (vm.isLoggingIn)
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () {
                    vm.login();
                  },
                  child: Text("Login"),
                ),
        ),
      ),
    );
  }
}
