import 'package:flutter/material.dart';

import 'screens/guest_area/welcome.dart';
import 'screens/route_manager.dart';

class StatefulWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeManager = RouteManager();
    return MaterialApp(
      title: 'StatefulWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: routeManager.onGenerateRoute,
      home: WelcomeScreen(),
    );
  }
}
