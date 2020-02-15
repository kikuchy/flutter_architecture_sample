import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';

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

  const RoomInsideScreen(
      {@required this.roomId,
      Key key})
      : assert(roomId != null),
        super(key: key);

  RoomInsideScreen.fromArgs(
      RoomInsideScreenArguments args,
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
    );
  }
}

class RoomInsideScreenArguments {
  final String roomId;

  const RoomInsideScreenArguments({@required this.roomId})
      : assert(roomId != null);
}

class _TranscriptArea extends StatelessWidget {
  final Stream<List<Transcript>> transcriptsStream;

  const _TranscriptArea({
    @required this.transcriptsStream,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transcript>>(
      stream: transcriptsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final transcripts = snapshot.data;
          return Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: transcripts.length,
                  itemBuilder: (context, i) {
                    final transcript = transcripts[i];
                    return ListTile(
                      title: Text(
                        transcript.postedBy,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      subtitle: Text(transcript.body),
                      trailing: Text(
                        "${transcript.postedAt.hour}:${transcript.postedAt.minute}",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .apply(color: Theme.of(context).dividerColor),
                      ),
                    );
                  }));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
                      maxHeight: MediaQuery.of(context).size.height * 0.75),
                  child: TextField(
                    controller: _controller,
                    onChanged: validate,
                    maxLines: null,
                    maxLength: maxBodyLength,
                  ))),
          _SendButton(
            valid: valid,
            postTranscript: () async {
              await widget.postTranscript(_controller.text);
              reset();
            },
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final bool valid;
  final Future<void> Function() postTranscript;

  _SendButton({@required this.valid, @required this.postTranscript});

  @override
  __SendButtonState createState() => __SendButtonState();
}

class __SendButtonState extends State<_SendButton> {
  bool sending = false;

  void send() async {
    setState(() {
      sending = true;
    });
    await widget.postTranscript();
    setState(() {
      sending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sending) {
      return const CircularProgressIndicator();
    } else {
      return IconButton(
        tooltip: "送信",
        onPressed: widget.valid ? send : null,
        icon: Icon(Icons.send),
      );
    }
  }
}
