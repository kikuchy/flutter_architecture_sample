import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/root_switcher.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:provider/provider.dart';

import 'screens/route_manager.dart';

class ScopedModelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeManager = RouteManager();
    return MultiProvider(
      providers: [
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
          create: (context) => RootSwitcher(Provider.of(
            context,
            listen: false,
          )),
          dispose: (_, switcher) => switcher.dispose(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'ScopedModel',
          navigatorKey: Provider.of<RootSwitcher>(
            context,
            listen: false,
          ).navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: routeManager.onGenerateRoute,
          home: Scaffold(
              body: const Center(
            child: CircularProgressIndicator(),
          )),
        ),
      ),
    );
  }
}
