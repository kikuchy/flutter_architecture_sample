import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/dummy_backend.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:flutter_architecture_samples/common/screens/root_switcher.dart';
import 'package:provider/provider.dart';

import '../../common/screens/route_manager.dart';
import 'screens/guest_area/make_profile.dart';
import 'screens/guest_area/welcome.dart';
import 'screens/member_area/room_inside.dart';
import 'screens/member_area/room_list.dart';

class ScopedModelApp extends StatelessWidget {
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
