import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/screens/guest_area/make_profile/model.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProfileValidationModel()),
        Provider.value(value: GlobalKey<ScaffoldState>()),
        ChangeNotifierProvider(
            create: (context) =>
                AccountRegistrationModel(Provider.of<AccountRepository>(
                  context,
                  listen: false,
                ))
                  ..addOnError((message) {
                    Provider.of<GlobalKey<ScaffoldState>>(context)
                        .currentState
                        .showSnackBar(SnackBar(content: Text(message)));
                  })),
      ],
      child: _ScreenContent(),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Provider.of<GlobalKey<ScaffoldState>>(context, listen: false),
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
      child: Column(
        children: <Widget>[
          Consumer<AccountProfileValidationModel>(
            builder: (context, model, child) => TextField(
              onChanged: (name) => model.validate(name),
              decoration: InputDecoration(
                labelText: "名前",
                errorText: model.nameErrorMessage,
              ),
              maxLength: AccountProfileValidationModel.maxNameLength,
            ),
          ),
          SizedBox(height: 16),
          _ToNextButtonArea(),
        ],
      ),
    );
  }
}

class _ToNextButtonArea extends StatelessWidget {
  const _ToNextButtonArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<AccountRegistrationModel, bool>(
      selector: (context, model) => model.loading,
      builder: (context, loading, _) {
        if (loading) {
          return const CircularProgressIndicator();
        } else {
          return Selector<AccountProfileValidationModel, bool>(
            selector: (context, model) => model.valid,
            builder: (context, valid, child) => AbsorbPointer(
              absorbing: valid,
              child: child,
            ),
            child: RaisedButton(
              child: Text("登録"),
              onPressed: () {
                final name = Provider.of<AccountProfileValidationModel>(
                  context,
                  listen: false,
                ).name;
                Provider.of<AccountRegistrationModel>(
                  context,
                  listen: false,
                ).register(name);
              },
            ),
          );
        }
      },
    );
  }
}
