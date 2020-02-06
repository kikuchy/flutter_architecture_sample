import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/ui/screens/guest_area/welcome.dart';
import 'package:flutter_architecture_samples/ui/screens/member_area/room_edit.dart';
import 'package:flutter_architecture_samples/ui/screens/member_area/room_inside.dart';
import 'package:flutter_architecture_samples/ui/screens/member_area/room_list.dart';
import 'package:flutter_architecture_samples/ui/screens/member_area/room_member.dart';
import 'package:flutter_architecture_samples/ui/screens/route_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeManager = RouteManager();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: routeManager.onGenerateRoute,
      home: RoomListScreen(),
    );
  }
}
