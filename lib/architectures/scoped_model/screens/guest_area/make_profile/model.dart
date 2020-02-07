import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/error_notify.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';

/// 参加者のプロフィールが受け入れ可能なものかどうか監視するモデル
class AccountProfileValidationModel extends ChangeNotifier {
  static const maxNameLength = 40;

  static String validateName(String name) {
    if (name.isEmpty) {
      return "名前を入力してください";
    }
    if (name.length > maxNameLength) {
      return "名前は${maxNameLength}文字以内である必要があります";
    }
    if (name.contains("\n")) {
      return "名前に改行を含めることはできません";
    }
    return null;
  }

  bool get valid => nameErrorMessage != null;
  String nameErrorMessage;
  String name;

  AccountProfileValidationModel() {
    validate("");
  }

  void validate(String name) {
    nameErrorMessage = validateName(name);
    if (nameErrorMessage != null) {
      this.name = name;
    }
    notifyListeners();
  }
}

/// 参加者の登録の進行状況を司るモデル
class AccountRegistrationModel extends ChangeNotifier with ErrorNotifyMixin {
  final AccountRepository _repository;

  MakeProfileModelState currentState = MakeProfileModelStateStandBy();

  bool get loading => currentState.loading;

  AccountRegistrationModel(this._repository);

  void register(String name) async {
    currentState = MakeProfileModelStateRegistering(name);
    notifyListeners();

    try {
      final uid = await _repository.createAccount(name: name);
      currentState = MakeProfileModelStateComplete(uid);
    } catch (e) {
      notifyError("ユーザー登録に失敗しました");
      currentState = MakeProfileModelStateStandBy();
    } finally {
      notifyListeners();
    }
  }
}

/// 状態を厳密に管理したい場合はクラスやenumで状態に名前をつけるのもあり。
/// 今回はパラメータを持たせるためにクラスにした。
abstract class MakeProfileModelState {
  bool get loading;

  const MakeProfileModelState();
}

/// まだユーザー登録処理を始めていない、またはエラーで終了した状態
class MakeProfileModelStateStandBy extends MakeProfileModelState {
  final bool loading = false;
  const MakeProfileModelStateStandBy();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeProfileModelStateStandBy && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

/// ユーザー登録中状態
class MakeProfileModelStateRegistering extends MakeProfileModelState {
  final bool loading = true;
  final String name;

  const MakeProfileModelStateRegistering(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeProfileModelStateRegistering &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

/// ユーザー登録終了状態
class MakeProfileModelStateComplete extends MakeProfileModelState {
  final bool loading = false;
  final String uid;

  const MakeProfileModelStateComplete(this.uid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeProfileModelStateComplete &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}