import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/account.dart';
import 'package:rxdart/rxdart.dart';

/// 参加者のプロフィールが受け入れ可能なものかどうか監視するBLoC
class ProfileValidation implements Bloc {
  static const maxNameLength = 40;

  BehaviorSubject<String> _name = BehaviorSubject.seeded("");

  StreamController<String> get name => _name;

  Stream<String> get validationError => _name.map(validateName);

  Stream<bool> get valid =>
      validationError.map((errorMessage) => errorMessage == null);

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

  @override
  void dispose() {
    _name.close();
  }
}

/// 参加者の登録の進行状況を司るBLoC
class AccountRegistrationBloc implements Bloc {
  final Stream<String> name;
  StreamController<Null> _register = StreamController.broadcast();

  StreamSink<Null> get register => _register;

  StreamController<bool> _sending = StreamController.broadcast();

  Stream<bool> get sending => _sending.stream;

  StreamController<String> _errorMessage = StreamController.broadcast();

  Stream<String> get errorMessage => _errorMessage.stream;

  final AccountRepository repository;

  AccountRegistrationBloc({
    @required this.name,
    @required this.repository,
  }) {
    _register.stream.flatMap((_) => name).listen((name) async {
      _sending.add(true);
      await repository.createAccount(name: name);
      _sending.add(false);
    }, onError: (err) => _errorMessage.add(err.toString()));
  }

  @override
  void dispose() {
    _errorMessage.close();
    _sending.close();
    _register.close();
  }
}
