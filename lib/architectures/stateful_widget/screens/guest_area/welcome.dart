import 'package:flutter/material.dart';
import 'make_profile.dart';

/// 未登録の利用者に最初に表示される画面
///
/// きっとSNSログインだとかの選択肢が出る画面でもある。
///
/// * 要件
///      * プロフィールの入力画面へ進む
class WelcomeScreen extends StatelessWidget {
  static const path = "/guest/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Text(
              "チャット",
              style: Theme.of(context).textTheme.headline2,
            )),
            RaisedButton(
                child: Text("はじめる"),
                onPressed: () {
                  Navigator.of(context).pushNamed(MakeProfileScreen.path);
                }),
          ],
        ),
      ),
    );
  }
}
