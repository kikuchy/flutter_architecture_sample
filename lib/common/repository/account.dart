import 'package:flutter/foundation.dart';

/// 利用者のアカウントを管理するバックエンドの操作抽象化した君
class AccountRepository {
  /// この端末でログイン中のユーザーIDを返します。ログインしていなかったらnull
  Future<String> currentUid() {}

  /// 名前を渡すと新しいユーザーIDを発行します。
  Future<String> createAccount({@required String name}) {}

  /// ユーザーIDからユーザー名を取得します。
  Future<String> getAccountNameById({@required String uid}) {}
}
