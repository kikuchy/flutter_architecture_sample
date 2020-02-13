import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'logic/state.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:flutter_architecture_samples/common/screens/root_switcher.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import '../../common/screens/route_manager.dart';
import 'screens/guest_area/make_profile.dart';
import 'screens/guest_area/welcome.dart';
import 'screens/member_area/room_inside.dart';
import 'screens/member_area/room_list.dart';

class ReduxApp extends StatelessWidget {
  final DummyBackend backend = DummyBackend();
  Store<AppState> store;
  RootSwitcher rootSwitcher;
  RouteManager routeManager;

  ReduxApp() {
    store = Store(
        appReducer,
        initialState: AppState(name: ""),
        middleware: [
          LoggingMiddleware.printer(),
          ...generateMiddleware(backend),
        ]
    );
    rootSwitcher = RootSwitcher(backend, WelcomeScreen.path, RoomListScreen.path);
    routeManager = RouteManager({
      WelcomeScreen.path: (context, _) => WelcomeScreen(),
      MakeProfileScreen.path: (context, _) => MakeProfileScreen(),
      RoomListScreen.path: (context, _) => RoomListScreen(backend, backend),
      RoomInsideScreen.path: (context, setting) =>
          RoomInsideScreen.fromArgs(setting.arguments, backend, backend),
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Redux',
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
