import 'package:flutter/foundation.dart';

/// 利用者のアカウントを管理するバックエンドの操作抽象化した君
abstract class AccountRepository {
  /// この端末でログイン中のユーザーIDを返します。ログインしていなかったらnull
  Future<String> currentUid();

  /// 現在ログインしているユーザーのIDを流します。
  /// ログアウトしていたらnullが流れてきます。
  /// ログイン状態が変わるたびに値が流れてきます。
  Stream<String> subscribeUid();

  /// 名前を渡すと新しいユーザーIDを発行します。
  Future<String> createAccount({@required String name});

  /// ユーザーIDからユーザー名を取得します。
  Future<String> getAccountNameById({@required String uid});

  /// ログアウトします。
  Future<void> logout();
}
