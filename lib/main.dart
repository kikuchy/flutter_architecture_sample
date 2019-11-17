import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/domain/login.dart';
import 'package:flutter_architecture_samples/domain/member.dart';
import 'package:flutter_architecture_samples/ui/home_page.dart';
import 'package:flutter_architecture_samples/ui/login_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'repository/repositories.dart';

void main() {
  final accountRepository = AccountRepository();
  final memberRepository = MemberRepository();
  final store = Store<LoginState>(
      combineReducers([
        loginReducer,
        memberReducer,
      ]),
      initialState: const LoginStateNotLoggedIn(),
      middleware: [
        EpicMiddleware<LoginState>(combineEpics([
          LoginEpic(accountRepository),
          MemberEpic(memberRepository),
        ])),
      ]);
  runApp(StoreProvider(store: store, child: MyApp(store)));
}

class MyApp extends StatefulWidget {
  final Store<LoginState> _store;

  MyApp(this._store);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    widget._store.onChange.skip(1).distinct((p, n) {
      return p.runtimeType == n.runtimeType;
    }).listen((state) {
      if (state is LoginStateNotLoggedIn) {
        _navKey.currentState.pushReplacementNamed("/");
      } else if (state is LoginStateLoggedIn) {
        _navKey.currentState.pushReplacementNamed("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/home": (context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}
