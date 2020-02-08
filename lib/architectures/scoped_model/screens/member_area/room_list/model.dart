import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';

class RoomListModel extends ChangeNotifier {
  final RoomRepository _room;
  final AccountRepository _account;
  StreamSubscription<List<Room>> _subscription;

  List<Room> rooms = [];
  RoomListModelState currentState = RoomListModelState.loading;

  RoomListModel(this._room, this._account) {
    _startSubscribing();
  }

  void _startSubscribing() async {
    final uid = await _account.currentUid();
    _subscription = _room.subscribeRooms(uid: uid).listen((event) {
      rooms.clear();
      rooms.addAll(event);
      currentState = RoomListModelState.done;
      notifyListeners();
    });
  }

  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}

enum RoomListModelState {
  loading,
  done,
}
