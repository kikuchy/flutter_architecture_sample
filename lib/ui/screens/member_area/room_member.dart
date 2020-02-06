import 'package:flutter/material.dart';

/// チャットルームに参加しているメンバーを管理する画面
///
/// * 要件
///     * 参加しているメンバーの一覧が表示される
///     * 参加しているメンバーをタップすると削除できる
///     * +ボタンからメンバーを追加できる
class RoomMemberScreen extends StatelessWidget {
  static const path = "/room/members";

  final String roomId;

  RoomMemberScreen({@required this.roomId, Key key})
      : assert(roomId != null),
        super(key: key);

  RoomMemberScreen.fromArgs(RoomMemberScreenArguments args, {Key key})
      : roomId = args.roomId,
        assert(args.roomId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メンバーの管理"),
      ),
      body: ListView.builder(
          itemBuilder: (context, i) => ListTile(
                leading: CircleAvatar(
                  child: Text("$i"),
                ),
                title: Text("$i"),
                onTap: () {},
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class RoomMemberScreenArguments {
  final String roomId;

  RoomMemberScreenArguments({this.roomId}) : assert(roomId != null);
}
