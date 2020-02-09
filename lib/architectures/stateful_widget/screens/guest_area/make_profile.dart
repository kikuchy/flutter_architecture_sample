import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';

const maxNameLength = 40;

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
class MakeProfileScreen extends StatefulWidget {
  static const path = "/guest/make_profile";

  final AccountRepository _repository;

  MakeProfileScreen(this._repository);

  @override
  _MakeProfileScreenState createState() => _MakeProfileScreenState();
}

class _MakeProfileScreenState extends State<MakeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール作成"),
      ),
      body: _ProfileForm(repository: widget._repository),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  final AccountRepository repository;

  const _ProfileForm({
    @required this.repository,
    Key key,
  }) : super(key: key);

  @override
  __ProfileFormState createState() => __ProfileFormState();
}

class __ProfileFormState extends State<_ProfileForm> {
  TextEditingController _controller;
  String nameValidationMessage;
  bool loading = false;

  bool get valid => nameValidationMessage == null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    validate(_controller.text);
  }

  void validate(String name) {
    setState(() {
      if (name.isEmpty) {
        nameValidationMessage = "名前を入力してください";
      } else if (name.length > maxNameLength) {
        nameValidationMessage = "名前は40文字以内でお願いします";
      } else {
        nameValidationMessage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        children: <Widget>[
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: "名前", errorText: nameValidationMessage),
            maxLength: maxNameLength,
            onChanged: validate,
          ),
          SizedBox(
            height: 16,
          ),
          _RegisterButton(
            repository: widget.repository,
            valid: valid,
            name: _controller.text,
          ),
        ],
      )),
    );
  }
}

class _RegisterButton extends StatefulWidget {
  final AccountRepository repository;
  final String name;
  final bool valid;

  _RegisterButton(
      {@required this.repository, @required this.name, @required this.valid});

  @override
  __RegisterButtonState createState() => __RegisterButtonState();
}

class __RegisterButtonState extends State<_RegisterButton> {
  bool loading = false;

  void register() async {
    setState(() {
      loading = true;
    });
    await widget.repository.createAccount(name: widget.name);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const CircularProgressIndicator();
    } else {
      return RaisedButton(
          child: Text("登録"), onPressed: widget.valid ? register : null);
    }
  }
}
