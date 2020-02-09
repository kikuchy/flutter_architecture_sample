import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:flutter_architecture_samples/common/screens/route_manager.dart';

import 'screens/guest_area/make_profile.dart';
import 'screens/guest_area/welcome.dart';
import 'screens/member_area/room_inside.dart';
import 'screens/member_area/room_list.dart';

class StatefulWidgetApp extends StatefulWidget {
  @override
  _StatefulWidgetAppState createState() => _StatefulWidgetAppState();
}

class _StatefulWidgetAppState extends State<StatefulWidgetApp> {
  // アプリケーション実行中に生きていてほしいインスタンス類もStatefulWidgetとして保持。
  // RepositoryやAPIクライアントなどをWidgetのコンストラクタ引数などから渡してゆくのは面倒なので、
  // scoped_modelでも使用しているpackage:providerを併用した方が楽。
  // （ただ、package:providerを初めから使うのであればscoped_modelの方が実装が楽になる気がする）。
  RouteManager _routeManager;
  DummyBackend _backend;

  @override
  void initState() {
    super.initState();

    _backend = DummyBackend();
    _routeManager = RouteManager({
      WelcomeScreen.path: (context, _) => WelcomeScreen(),
      MakeProfileScreen.path: (context, _) => MakeProfileScreen(_backend),
      RoomListScreen.path: (context, _) => RoomListScreen(_backend, _backend),
      RoomInsideScreen.path: (context, setting) =>
          RoomInsideScreen.fromArgs(setting.arguments, _backend, _backend),
    });
  }

  @override
  void dispose() {
    super.dispose();

    _backend.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _routeManager.onGenerateRoute,
      home: StreamBuilder<bool>(
        stream: _backend.subscribeUid().map((uid) => uid != null).distinct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            scheduleMicrotask(() {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            return (snapshot.data)
                ? RoomListScreen(_backend, _backend)
                : WelcomeScreen();
          } else {
            return Scaffold(
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
