import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';
import 'package:flutter_architecture_samples/common/repository/room.dart';

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
