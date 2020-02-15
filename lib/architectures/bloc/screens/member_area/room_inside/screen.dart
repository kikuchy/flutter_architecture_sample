import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

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
    return ChangeNotifierProvider<TextEditingController>(
      create: (context) => TextEditingController(),
      child: BlocProviderTree(blocProviders: [
        BlocProvider<TranscriptHistoryBloc>(
          creator: (context, bag) => TranscriptHistoryBloc(
              roomId,
              Provider.of(
                context,
                listen: false,
              )),
        ),
        BlocProvider<MessageBloc>(
          creator: (context, bag) {
            final bloc = MessageBloc(
              roomId: roomId,
              accountRepository: Provider.of(
                context,
                listen: false,
              ),
              roomRepository: Provider.of(
                context,
                listen: false,
              ),
            );
            final subscription = bloc.result.listen((result) {
              switch (result) {
                case MessageSendResult.failure:
                  break;
                case MessageSendResult.success:
                  Provider.of<TextEditingController>(context, listen: false)
                      .clear();
                  break;
              }
            });
            bag.register(onDisposed: () {
              subscription.cancel();
            });
            return bloc;
          },
        )
      ], child: _Content()),
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
    final bloc = BlocProvider.of<TranscriptHistoryBloc>(context);

    return StreamBuilder<List<Transcript>>(
      stream: bloc.transcripts,
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

class _InputControlArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MessageBloc>(context);

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
                    controller: Provider.of(context, listen: false),
                    onChanged: bloc.body.add,
                    maxLines: null,
                    maxLength: maxBodyLength,
                  ))),
          StreamBuilder<bool>(
              stream: bloc.valid,
              builder: (context, snapshot) => _SendButton(
                    valid: snapshot.data ?? false,
                    postTranscript: () {
                      bloc.send.add(null);
                    },
                  )),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool valid;
  final void Function() postTranscript;

  _SendButton({
    @required this.valid,
    @required this.postTranscript,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MessageBloc>(context);
    return StreamBuilder<bool>(
      stream: bloc.sending,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return const CircularProgressIndicator();
        } else {
          return IconButton(
            tooltip: "送信",
            onPressed: valid ? postTranscript : null,
            icon: Icon(Icons.send),
          );
        }
      },
    );
  }
}
