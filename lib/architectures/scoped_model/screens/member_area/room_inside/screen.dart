import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/member_area/room_inside/model.dart';
import 'package:provider/provider.dart';

import '../room_edit.dart';
import '../room_member.dart';

/// チャットルームの中身の画面
/// ここで会話を楽しみます。
///
/// * 要件
///     * メッセージの送信ができる
///         * メッセージは最大1000文字
///         * 空文字は送信できない
///         * 送信できない場合は送信ボタンが無効になる
///     * メッセージの履歴を見ることができる
///         * 誰がいつどんな内容で送ったのか見える
///         * 新しいメッセージがあった場合は自動的に表示が更新される
///     * チャットルームの名前を変更できる画面へ遷移できる
///     * チャットルームのメンバーを管理できる画面へ遷移できる
class RoomInsideScreen extends StatelessWidget {
  static const path = "/room/inside";

  final String roomId;

  const RoomInsideScreen({@required this.roomId, Key key})
      : assert(roomId != null),
        super(key: key);

  RoomInsideScreen.fromArgs(RoomInsideScreenArguments args, {Key key})
      : roomId = args.roomId,
        assert(args.roomId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TranscriptHistoryModel>(
            create: (context) => TranscriptHistoryModel(
                Provider.of(
                  context,
                  listen: false,
                ),
                roomId)),
      ],
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
      appBar: _HeaderArea(),
      body: Column(
        children: <Widget>[
          _TranscriptArea(),
          _InputControlArea(),
        ],
      ),
    );
  }
}

class _HeaderArea extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("TODO"),
      actions: <Widget>[
        Tooltip(
          child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(RoomEditScreen.path,
                    arguments: RoomEditScreenArguments(roomId: "TODO"));
              }),
          message: "編集",
        ),
        Tooltip(
          child: IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Navigator.of(context).pushNamed(RoomMemberScreen.path,
                  arguments: RoomMemberScreenArguments(roomId: "TODO"));
            },
          ),
          message: "メンバーの管理",
        ),
      ],
    );
  }
}

class RoomInsideScreenArguments {
  final String roomId;

  const RoomInsideScreenArguments({@required this.roomId})
      : assert(roomId != null);
}

class _TranscriptArea extends StatelessWidget {
  const _TranscriptArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<TranscriptHistoryModel>(
      builder: (context, model, _) {
        final transcripts = model.transcripts;
        return ListView.builder(
            reverse: true,
            itemCount: transcripts.length,
            itemBuilder: (context, i) {
              final transcript = transcripts[i];
              return ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "TODO: 人の名前 ${transcript.postedBy}",
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${transcript.postedAt.hour}:${transcript.postedAt.minute}",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .apply(color: Theme.of(context).dividerColor),
                    ),
                  ],
                ),
                subtitle: Text(transcript.body),
              );
            });
      },
    ));
  }
}

class _InputControlArea extends StatelessWidget {
  const _InputControlArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black12),
      child: Row(
        children: <Widget>[
          Expanded(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.75),
                  child: TextField(
                    maxLines: null,
                    maxLength: 1000,
                  ))),
          Tooltip(
            message: "送信",
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
