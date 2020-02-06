import 'package:flutter/foundation.dart';

/// 利用者のアカウントを管理するバックエンドの操作抽象化した君
class AccountRepository {
  Future<String> createAccount({@required String name}) {}

  Future<String> getAccountNameById({@required String uid}) {}
}
