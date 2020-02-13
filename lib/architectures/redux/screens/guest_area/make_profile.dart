import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/actions.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/reducers.dart';
import 'package:flutter_architecture_samples/architectures/redux/logic/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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

  MakeProfileScreen();

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
      body: _ProfileForm(),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        children: <Widget>[
          StoreConnector<AppState, _ProfileFormViewModel>(
            converter: (store) => _ProfileFormViewModel.from(store),
            onInitialBuild: (vm) => vm.validate(""),
            builder: (context, vm) => TextFormField(
              decoration: InputDecoration(
                  labelText: "名前", errorText: vm.validationError),
              maxLength: maxNameLength,
              onChanged: vm.validate,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _RegisterButton(),
        ],
      )),
    );
  }
}

class _ProfileFormViewModel {
  final String validationError;
  final void Function(String) validate;

  _ProfileFormViewModel({
    @required this.validationError,
    @required this.validate,
  });

  factory _ProfileFormViewModel.from(Store<AppState> store) {
    return _ProfileFormViewModel(
        validationError: store.state.registrationState.validationError,
        validate: (newName) {
          store.dispatch(ValidateName(newName));
        });
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _RegisterButtonViewModel>(
      converter: (store) => _RegisterButtonViewModel.from(store),
      builder: (context, vm) {
        if (vm.loading) {
          return const CircularProgressIndicator();
        } else {
          return RaisedButton(
              child: const Text("登録"),
              onPressed: vm.valid ? vm.register : null);
        }
      },
    );
  }
}

class _RegisterButtonViewModel {
  final bool valid;
  final bool loading;
  final void Function() register;

  _RegisterButtonViewModel({
    @required this.valid,
    @required this.loading,
    @required this.register,
  });

  factory _RegisterButtonViewModel.from(Store<AppState> store) =>
      _RegisterButtonViewModel(
        valid: store.state.registrationState.valid,
        loading: store.state.registrationState is RegistrationStateLoading,
        register: () {
          store.dispatch(Register());
        },
      );
}
