import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/root_switcher.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:provider/provider.dart';

import 'screens/route_manager.dart';

class ScopedModelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeManager = RouteManager();
    final backend = DummyBackend();
    final RootSwitcher rootSwitcher = RootSwitcher.subscribeLoginState(backend);
    return MultiProvider(
      providers: [
        Provider<DummyBackend>(
          create: (_) => backend,
          dispose: (_, b) => b.dispose(),
        ),
        Provider<AccountRepository>.value(value: backend),
        Provider<RootSwitcher>(
          create: (context) => rootSwitcher,
          dispose: (_, switcher) => switcher.dispose(),
        )
      ],
      child: MaterialApp(
        title: 'ScopedModel',
        navigatorKey: rootSwitcher.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routeManager.onGenerateRoute,
        home: Scaffold(
            body: const Center(
          child: CircularProgressIndicator(),
        )),
      ),
    );
  }
}
