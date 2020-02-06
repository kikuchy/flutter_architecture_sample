import 'package:flutter/material.dart';

/// ユーザーの登録時に入力しておいて欲しいプロフィールの入力画面。
///
/// * 要件
///     * 利用者は名前を入れる必要がある
///         * 名前は空文字列ではいけない
///         * 名前は改行文字を含んではいけない
///         * 名前は文字種を問わず40文字以内である必要がある
///         * validでない場合、原因は利用者に呈示される必要がある
///     * 名前がvalidであるときのみ登録ボタンが有効になる
///     * 登録ボタンを押下したらユーザーが登録される
///     * 登録後はチャットルームの一覧画面へ移動
class MakeProfileScreen extends StatelessWidget {
  static const path = "/guest/make_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール作成"),
      ),
      body: _ProfileForm(),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  const _ProfileForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "名前"),
            maxLength: 40,
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(child: Text("登録"),onPressed: () {}),
        ],
      )),
    );
  }
}
