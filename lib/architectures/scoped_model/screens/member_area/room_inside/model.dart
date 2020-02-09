import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/error_notify.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';

/// チャットルームの発言履歴を司るモデル
class TranscriptHistoryModel extends ChangeNotifier {
  final RoomRepository _repository;
  final List<Transcript> transcripts = [];
  StreamSubscription<List<Transcript>> _subscription;

  TranscriptHistoryModel(this._repository, String roomId) {
    _subscription =
        _repository.subscribeTranscripts(roomId: roomId).listen((t) {
      transcripts.clear();
      transcripts.addAll(t);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}

/// 入力しかけのテキストが受け入れ可能なものか確かめるモデル
class DraftValidationModel extends ChangeNotifier {
  static const maxBodyLength = 1000;
  bool valid = false;
  String body = "";

  void validate(String message) {
    valid = message.isNotEmpty && (message.length <= maxBodyLength);
    body = message;
    notifyListeners();
  }

  void clear() {
    validate("");
  }
}

/// チャットルームに新しい発言を投稿するモデル
class PostTranscriptModel extends ChangeNotifier with ErrorNotifyMixin {
  final RoomRepository _room;
  final AccountRepository _account;
  final String roomId;
  final void Function() onPostComplete;
  PostTranscriptModelState currentState = PostTranscriptModelState.done;

  PostTranscriptModel(this._room, this._account, this.roomId, this.onPostComplete);

  void post(String body) async {
    if (currentState != PostTranscriptModelState.done) {
      return;
    }

    currentState = PostTranscriptModelState.sending;
    notifyListeners();

    try {
      final uid = await _account.currentUid();
      await _room.postTranscript(roodId: roomId, uid: uid, content: body);
      onPostComplete();
    } catch (e) {
      print(e);
      notifyError("送信失敗しました");
    } finally {
      currentState = PostTranscriptModelState.done;
      notifyListeners();
    }
  }
}

enum PostTranscriptModelState {
  sending,
  done,
}
