import 'package:flutter/material.dart';
import 'member_area/room_edit.dart';
import 'member_area/room_inside/screen.dart';

import 'guest_area/make_profile/screen.dart';
import 'guest_area/welcome.dart';
import 'member_area/room_list/screen.dart';
import 'member_area/room_member.dart';

/// どんな[Route]があるのか管理するくん
class RouteManager {
  static final Map<String, Widget Function(BuildContext, RouteSettings)>
      _routes = {
    WelcomeScreen.path: (context, _) => WelcomeScreen(),
    MakeProfileScreen.path: (context, _) => MakeProfileScreen(),
    RoomListScreen.path: (context, _) => RoomListScreen(),
    RoomInsideScreen.path: (context, setting) =>
        RoomInsideScreen.fromArgs(setting.arguments),
    RoomEditScreen.path: (context, setting) =>
        RoomEditScreen.fromArgs(setting.arguments),
    RoomMemberScreen.path: (context, setting) =>
        RoomMemberScreen.fromArgs(setting.arguments),
  };

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
