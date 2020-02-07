import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:provider/provider.dart';
import 'room_inside.dart';

/// チャットルーム一覧が表示される画面
///
/// * 要件
///     * 利用者が所属しているチャットルームが表示される
///         * チャットルームの最終更新日時でソートされている
///         * チャットルームの最終更新日時が変更されたとき、画面にも順番の変更が反映される
///         * タップするとチャットルームへ移動できる
///     * 自分のIDが表示される
///     * ログアウトできる
class RoomListScreen extends StatelessWidget {
  static const path = "/room/list";

  @override
  Widget build(BuildContext context) {
    return _Content();
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
              Provider.of<AccountRepository>(context, listen: false,).logout();
            },
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, i) {
            return ListTile(
              title: Text("$i"),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RoomInsideScreen.path,
                  arguments: RoomInsideScreenArguments(roomId: "$i"),
                );
              },
            );
          },
          separatorBuilder: (context, i) => const Divider(),
          itemCount: 1000),
    );
  }
}
