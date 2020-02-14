import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/actions.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/state.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'room_inside.dart';

/// チャットルーム一覧が表示される画面
///
/// * 要件
///     * 利用者が所属しているチャットルームが表示される
///         * チャットルームの最終更新日時でソートされている
///         * チャットルームの最終更新日時が変更されたとき、画面にも順番の変更が反映される
///         * タップするとチャットルームへ移動できる
///     * 自分のIDが表示される
class RoomListScreen extends StatelessWidget {
  static const path = "/room/list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一覧"),
      ),
      body: StoreConnector<AppState, List<Room>>(
        converter: (store) => store.state.roomListState.rooms,
          onInit: (store) => store.dispatch(StartSubscribingRoomList()),
          builder: (context, rooms) {
            if (rooms != null) {
              if (rooms.isNotEmpty) {
                return ListView.separated(
                    itemBuilder: (context, i) {
                      final room = rooms[i];
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(child: Text(room.name)),
                            Text(
                              "${room.lastTranscriptPostedAt.hour}:${room.lastTranscriptPostedAt.minute}",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoomInsideScreen.path,
                            arguments:
                            RoomInsideScreenArguments(roomId: room.roomId),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, i) => const Divider(),
                    itemCount: rooms.length);
              } else {
                return const _EmptyRoomList();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },),
    );
  }
}

class _EmptyRoomList extends StatelessWidget {
  const _EmptyRoomList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "まだチャットルームに参加していません",
            style: Theme.of(context).textTheme.headline5,
          ),
          Text("新しいチャットルームを作って、友達を誘ってみましょう！"),
          RaisedButton(
              child: Text("チャットルームを作る"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("この機能はこのサンプルでは実装していません！ごめんね！"),
                          actions: <Widget>[
                            RaisedButton(
                              child: const Text("閉じる"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              }),
        ],
      ),
    );
  }
}
