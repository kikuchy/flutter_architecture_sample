import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:flutter_architecture_samples/common/screens/root_switcher.dart';
import 'package:provider/provider.dart';

import '../../common/screens/route_manager.dart';
import 'screens/guest_area/make_profile/screen.dart';
import 'screens/guest_area/welcome.dart';
import 'screens/member_area/room_inside.dart';
import 'screens/member_area/room_list/screen.dart';

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RouteManager>(
            create: (_) => RouteManager({
              WelcomeScreen.path: (context, _) => WelcomeScreen(),
              MakeProfileScreen.path: (context, _) => MakeProfileScreen(),
              RoomListScreen.path: (context, _) => RoomListScreen(),
              RoomInsideScreen.path: (context, setting) =>
                  RoomInsideScreen.fromArgs(setting.arguments),
            })),
        Provider<DummyBackend>(
          create: (_) => DummyBackend(),
          dispose: (_, b) => b.dispose(),
        ),
        Provider<AccountRepository>(
          create: (context) => Provider.of<DummyBackend>(
            context,
            listen: false,
          ),
        ),
        Provider<RoomRepository>(
          create: (context) => Provider.of<DummyBackend>(
            context,
            listen: false,
          ),
        ),
        Provider<RootSwitcher>(
          create: (context) => RootSwitcher(
              Provider.of(
                context,
                listen: false,
              ),
              WelcomeScreen.path,
              RoomListScreen.path),
          dispose: (_, switcher) => switcher.dispose(),
          lazy: false,
        ),
      ],
      child: _AppContent(),
    );
  }
}

class _AppContent extends StatelessWidget {
  const _AppContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC',
      navigatorKey: Provider.of<RootSwitcher>(
        context,
        listen: false,
      ).navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Provider.of<RouteManager>(
        context,
        listen: false,
      ).onGenerateRoute,
      home: Scaffold(
          body: const Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
