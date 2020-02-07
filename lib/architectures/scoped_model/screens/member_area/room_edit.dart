import 'package:flutter/material.dart';

class RoomEditScreen extends StatelessWidget {
  static const path = "/room/edit";

  final String roomId;

  RoomEditScreen({@required this.roomId, Key key})
      : assert(roomId != null),
        super(key: key);

  RoomEditScreen.fromArgs(RoomEditScreenArguments args, {Key key})
      : roomId = args.roomId,
        assert(args.roomId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ルーム情報の編集"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "ルーム名"),
              maxLength: 40,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("確定"),
            )
          ],
        )),
      ),
    );
  }
}

class RoomEditScreenArguments {
  final String roomId;

  RoomEditScreenArguments({@required this.roomId}) : assert(roomId != null);
}
