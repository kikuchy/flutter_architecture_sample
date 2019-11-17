import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/domain/login.dart';
import 'package:flutter_architecture_samples/domain/member.dart';
import 'package:flutter_architecture_samples/repository/repositories.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class _MemberViewModel {
  final MemberState _state;
  final Store<LoginState> _store;

  _MemberViewModel(this._store, this._state);

  bool get isLoading => _state is MemberStateLoading;

  List<Member> get members => _state.members;

  Future<void> reload() {
    scheduleMicrotask(() {
      _store.dispatch(MemberActionRefresh());
    });
    return _store.onChange
        .where((s) =>
            (s is LoginStateLoggedIn) && (s.memberState is MemberStateLoaded))
        .skip(1)
        .first;
  }
}

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<LoginState, _MemberViewModel>(
      ignoreChange: (state) => state is! LoginStateLoggedIn,
      converter: (store) => _MemberViewModel(
          store, (store.state as LoginStateLoggedIn).memberState),
      builder: (context, vm) => RefreshIndicator(
          child: ListView.builder(
              itemCount: vm.members.length,
              itemBuilder: (context, i) {
                final m = vm.members[i];
                return ListTile(
                  leading: Image.network(m.picture),
                  title: Text(m.name),
                );
              }),
          onRefresh: () {
            return vm.reload();
          }),
    );
  }
}
