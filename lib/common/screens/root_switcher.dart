import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';

/// ログイン状態に合わせてルートの画面を切り替える君
class RootSwitcher {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final String nameOfGuestRoot;
  final String nameOfMemberRoot;
  StreamSubscription<bool> _subscription;

  RootSwitcher(AccountRepository repository, this.nameOfGuestRoot, this.nameOfMemberRoot) {
    _subscription = repository
        .subscribeUid()
        .distinct()
        .map((event) => event != null)
        .listen((loggedIn) {
      onLoginStateChanged(loggedIn);
    });
  }

  void _switchRootToNamed(String name) {
    navigatorKey.currentState.popUntil((route) => route.isFirst);
    navigatorKey.currentState?.pushReplacementNamed(name);
  }

  void onLoginStateChanged(bool loggedIn) {
    _switchRootToNamed(loggedIn ? nameOfMemberRoot : nameOfGuestRoot);
  }

  void dispose() {
    _subscription.cancel();
  }
}
