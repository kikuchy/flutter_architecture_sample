import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

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
class MakeProfileScreen extends StatelessWidget {
  static const path = "/guest/make_profile";

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(blocProviders: [
      BlocProvider<ProfileValidation>(
        creator: (context, bag) => ProfileValidation(),
      ),
      BlocProvider<AccountRegistrationBloc>(creator: (context, bag) => AccountRegistrationBloc(
        name: BlocProvider.of<ProfileValidation>(context).name.stream,
        repository: Provider.of(context, listen: false),
      ),),
    ], child: _Content(),);
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key key,
  }) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    final validationBloc = BlocProvider.of<ProfileValidation>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        children: <Widget>[
          StreamBuilder<String>(
            stream: validationBloc.validationError,
            builder: (context, snapshot) => TextFormField(
              decoration:
                  InputDecoration(labelText: "名前", errorText: snapshot.data),
              maxLength: maxNameLength,
              onChanged: validationBloc.name.add,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          StreamBuilder<bool>(
            stream: validationBloc.valid,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _RegisterButton(
                  valid: snapshot.data,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      )),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final bool valid;

  const _RegisterButton({@required this.valid});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountRegistrationBloc>(context);
    return StreamBuilder<bool>(
      stream: bloc.sending,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return const CircularProgressIndicator();
        } else {
          return RaisedButton(
              child: Text("登録"), onPressed: valid ? (){
                bloc.register.add(null);
          } : null);
        }
      },
    );
  }
}
