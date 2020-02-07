import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/guest_area/welcome.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/member_area/room_list.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';

/// ログイン状態に合わせてルートの画面を切り替える君
class RootSwitcher {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  StreamSubscription<bool> _subscription;

  static subscribeLoginState(AccountRepository repository) {
    final this$ = RootSwitcher();
    this$._subscription = repository
        .subscribeUid()
    .doOnData(print)
        .distinct()
        .map((event) => event != null)
        .listen((loggedIn) {
      this$.onLoginStateChanged(loggedIn);
    });
    return this$;
  }

  void _switchRootToNamed(String name) {
    navigatorKey.currentState.popUntil((route) => route.isFirst);
    navigatorKey.currentState?.pushReplacementNamed(name);
  }

  void onLoginStateChanged(bool loggedIn) {
    _switchRootToNamed(loggedIn ? RoomListScreen.path : WelcomeScreen.path);
  }

  void dispose() {
    _subscription.cancel();
  }
}
