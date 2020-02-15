import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../..//logic/state.dart';
import '../../logic/actions.dart';

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

  const RoomInsideScreen({@required this.roomId, Key key})
      : assert(roomId != null),
        super(key: key);

  RoomInsideScreen.fromArgs(RoomInsideScreenArguments args, {Key key})
      : roomId = args.roomId,
        assert(args.roomId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _HeaderArea(),
      body: Column(
        children: <Widget>[
          _TranscriptArea(
            roomId: roomId,
          ),
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
  final String roomId;

  const _TranscriptArea({
    @required this.roomId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Transcript>>(
      converter: (store) => store.state.roomInsideState.transcripts,
      onInit: (store) => store.dispatch(StartSubscribingRoom(roomId)),
      onDispose: (store) => store.dispatch(UnsubscribeRoom(roomId)),
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
      },
    );
  }
}

class _InputControlArea extends StatefulWidget {
  @override
  __InputControlAreaState createState() => __InputControlAreaState();
}

class __InputControlAreaState extends State<_InputControlArea> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black12),
      child: StoreConnector<AppState, _InputControlAreaViewModel>(
        converter: (store) => _InputControlAreaViewModel(
            updateDraft: (body) => store.dispatch(UpdateDraft(body)),
            valid: store.state.roomInsideState.valid,
            draft: store.state.roomInsideState.draft,
            postTranscript: () {
              store.dispatch(SendMessage());
              controller.clear();
            }),
        builder: (context, vm) => Row(
          children: <Widget>[
            Expanded(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.75),
                    child: TextField(
                      controller: controller,
                      onChanged: (body) {
                        vm.updateDraft(body);
                      },
                      maxLines: null,
                      maxLength: maxBodyLength,
                    ))),
            _SendButton(
              valid: vm.valid,
              send: vm.postTranscript,
            ),
          ],
        ),
      ),
    );
  }
}

class _InputControlAreaViewModel {
  final void Function(String) updateDraft;
  final bool valid;
  final String draft;
  final void Function() postTranscript;

  _InputControlAreaViewModel({
    @required this.updateDraft,
    @required this.valid,
    @required this.draft,
    @required this.postTranscript,
  });
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
