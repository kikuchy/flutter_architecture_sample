import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/state.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';
import 'package:flutter_redux/flutter_redux.dart';

const maxBodyLength = 1000;

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

  const RoomInsideScreen({@required this.roomId,
    Key key})
      : assert(roomId != null),
        super(key: key);

  RoomInsideScreen.fromArgs(RoomInsideScreenArguments args,
      {Key key})
      : roomId = args.roomId,
        assert(args.roomId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _HeaderArea(),
      body: Column(
        children: <Widget>[
          _TranscriptArea(),
          _InputControlArea(
            postTranscript: (message) async {
              final uid = await account.currentUid();
              return room.postTranscript(
                  roodId: roomId, uid: uid, content: message);
            },
          ),
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
    return StoreConnector<AppState, List<Transcript>>(
      converter: (store) => store.state.roomInsideState.transcripts,
      builder: (context, transcripts) {
        return Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: transcripts.length,
                itemBuilder: (context, i) {
                  final transcript = transcripts[i];
                  return ListTile(
                    title: Text(
                      transcript.postedBy,
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption,
                    ),
                    subtitle: Text(transcript.body),
                    trailing: Text(
                      "${transcript.postedAt.hour}:${transcript.postedAt
                          .minute}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .apply(color: Theme
                          .of(context)
                          .dividerColor),
                    ),
                  );
                }));
      },);
  }
}

class _InputControlArea extends StatefulWidget {
  final Future<void> Function(String) postTranscript;

  const _InputControlArea({
    @required this.postTranscript,
    Key key,
  }) : super(key: key);

  @override
  __InputControlAreaState createState() => __InputControlAreaState();
}

class __InputControlAreaState extends State<_InputControlArea> {
  TextEditingController _controller;
  bool valid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    reset();
  }

  void validate(String message) {
    setState(() {
      valid = message.isNotEmpty && message.length < maxBodyLength;
    });
  }

  void reset() {
    _controller.clear();
    validate(_controller.text);
  }

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
                      maxHeight: MediaQuery
                          .of(context)
                          .size
                          .height * 0.75),
                  child: TextField(
                    controller: _controller,
                    onChanged: validate,
                    maxLines: null,
                    maxLength: maxBodyLength,
                  ))),
          _SendButton(
            valid: valid,
            send: () {

              await widget.postTranscript(_controller.text);
              reset();
            },
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool valid;
  final void Function() send;
  _SendButton({@required this.valid, @required this.send});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.roomInsideState.sending,
      builder: (context, sending) {
        if (sending) {
          return const CircularProgressIndicator();
        } else {
          return IconButton(
            tooltip: "送信",
            onPressed: valid ? send : null,
            icon: Icon(Icons.send),
          );
        }
      },
    );
  }
}
