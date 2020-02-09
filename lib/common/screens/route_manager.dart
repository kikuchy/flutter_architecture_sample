import 'package:flutter/material.dart';

/// どんな[Route]があるのか管理するくん
class RouteManager {
  final Map<String, Widget Function(BuildContext, RouteSettings)> _routes;

  RouteManager(this._routes);

  Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      final route = _routes[settings.name];
      if (route == null) {
        throw NoSuchRouteError(settings);
      }
      return route(context, settings);
    });
  }
}

class NoSuchRouteError extends Error {
  final RouteSettings routeSettings;

  NoSuchRouteError(this.routeSettings);
}
