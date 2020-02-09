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
        Provider<GlobalKey<ScaffoldState>>.value(value: GlobalKey()),
        ChangeNotifierProvider<TextEditingController>.value(
          value: TextEditingController(),
        ),
        ChangeNotifierProvider<TranscriptHistoryModel>(
            create: (context) => TranscriptHistoryModel(
                Provider.of(
                  context,
                  listen: false,
                ),
                roomId)),
        ChangeNotifierProvider<DraftValidationModel>(
          create: (context) => DraftValidationModel(),
        ),
        ChangeNotifierProvider<PostTranscriptModel>(
            create: (context) => PostTranscriptModel(
                    Provider.of(
                      context,
                      listen: false,
                    ),
                    Provider.of(
                      context,
                      listen: false,
                    ),
                    roomId, () {
                  Provider.of<DraftValidationModel>(
                    context,
                    listen: false,
                  ).clear();
                  Provider.of<TextEditingController>(
                    context,
                    listen: false,
                  ).clear();
                })
                  ..addOnError((message) {
                    Provider.of<GlobalKey<ScaffoldState>>(
                      context,
                      listen: false,
                    )
                        .currentState
                        .showSnackBar(SnackBar(content: Text(message)));
                  })),
      ],
      child: _Content(),
    );
  }
}

class RoomInsideScreenArguments {
  final String roomId;

  const RoomInsideScreenArguments({@required this.roomId})
      : assert(roomId != null);
}

class _Content extends StatelessWidget {
  const _Content({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Provider.of<GlobalKey<ScaffoldState>>(
        context,
        listen: false,
      ),
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
                        transcript.postedBy,
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
                    controller: Provider.of<TextEditingController>(
                      context,
                      listen: false,
                    ),
                    maxLines: null,
                    maxLength: 1000,
                    onChanged: (message) {
                      Provider.of<DraftValidationModel>(
                        context,
                        listen: false,
                      ).validate(message);
                    },
                  ))),
          Selector<DraftValidationModel, bool>(
            selector: (context, model) => model.valid,
            builder: (context, valid, child) =>
                Selector<PostTranscriptModel, bool>(
              selector: (context, model) =>
                  model.currentState == PostTranscriptModelState.sending,
              builder: (context, sending, _) {
                if (sending) {
                  return const CircularProgressIndicator();
                } else {
                  return IconButton(
                    tooltip: "送信",
                    onPressed: valid
                        ? () {
                            Provider.of<PostTranscriptModel>(
                              context,
                              listen: false,
                            ).post(Provider.of<DraftValidationModel>(
                              context,
                              listen: false,
                            ).body);
                          }
                        : null,
                    icon: Icon(Icons.send),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
