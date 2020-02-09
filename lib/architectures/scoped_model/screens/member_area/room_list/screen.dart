import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:provider/provider.dart';

import '../room_inside/screen.dart';
import 'model.dart';

/// チャットルーム一覧が表示される画面
///
/// * 要件
///     * 利用者が所属しているチャットルームが表示される
///         * チャットルームの最終更新日時でソートされている
///         * チャットルームの最終更新日時が変更されたとき、画面にも順番の変更が反映される
///         * タップするとチャットルームへ移動できる
///         * 参加しているチャットルームがないときは、チャットルームを作ってみることを勧める
///     * ログアウトできる
class RoomListScreen extends StatelessWidget {
  static const path = "/room/list";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomListModel(
          Provider.of(
            context,
            listen: false,
          ),
          Provider.of(
            context,
            listen: false,
          )),
      child: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一覧"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: "ログアウト",
            onPressed: () {
              Provider.of<AccountRepository>(
                context,
                listen: false,
              ).logout();
            },
          )
        ],
      ),
      body: _ListArea(),
    );
  }
}

class _ListArea extends StatelessWidget {
  const _ListArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RoomListModel, bool>(
      builder: (context, loading, _) {
        if (loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Selector<RoomListModel, bool>(
            builder: (context, isEmpty, _) {
              if (isEmpty) {
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
                                      title: const Text(
                                          "この機能はこのサンプルでは実装していません！ごめんね！"),
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
              } else {
                return Consumer<RoomListModel>(builder: (context, model, _) {
                  final rooms = model.rooms;
                  return ListView.separated(
                    itemBuilder: (context, i) {
                      final room = rooms[i];
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Text(room.name),
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
                    itemCount: rooms.length,
                  );
                });
              }
            },
            selector: (context, model) => model.rooms.isEmpty,
          );
        }
      },
      selector: (context, model) =>
          model.currentState == RoomListModelState.loading,
    );
  }
}
