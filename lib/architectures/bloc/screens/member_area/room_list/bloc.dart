import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';

class RoomListBloc implements Bloc {
  Stream<List<Room>> rooms;

  final AccountRepository accountRepository;
  final RoomRepository roomRepository;

  RoomListBloc({
    @required this.accountRepository,
    @required this.roomRepository,
  }) {
    accountRepository.currentUid().then((uid) {
      rooms = roomRepository.subscribeRooms(uid: uid);
    });
  }

  @override
  void dispose() {
  }
}
