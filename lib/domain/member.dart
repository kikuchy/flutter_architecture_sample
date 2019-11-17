import 'package:flutter_architecture_samples/domain/login.dart';
import 'package:flutter_architecture_samples/repository/repositories.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class MemberActionRefresh {}

class MemberActionLoading {}

class MemberActionLoaded {
  final List<Member> members;

  MemberActionLoaded(this.members);
}

abstract class MemberState {
  final List<Member> members;

  const MemberState([this.members = const <Member>[]]);
}

class MemberStateLoading extends MemberState {
  const MemberStateLoading([List<Member> members = const []]) : super(members);
}

class MemberStateLoaded extends MemberState {
  const MemberStateLoaded([List<Member> members = const []]) : super(members);
}

LoginState Function(LoginState, dynamic)
    _memberReducer<S extends MemberState, A>(
        MemberState Function(S, A) reducer) {
  return needsLoginTypedAction<A>((state, action) {
    if (state.memberState is S) {
      final newMemberState = reducer(state.memberState, action);
      return state.edit(memberState: newMemberState);
    }
    return state;
  });
}

final _reducerLoading = _memberReducer<MemberStateLoaded, MemberActionLoading>(
    (state, action) => MemberStateLoading([]));

final _reducerLoaded = _memberReducer<MemberStateLoading, MemberActionLoaded>(
    (state, action) => MemberStateLoaded(action.members));

final memberReducer = combineReducers([
  _reducerLoading,
  _reducerLoaded,
]);

class MemberEpic extends EpicClass<LoginState> {
  final MemberRepository _repository;

  MemberEpic(this._repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<LoginState> store) {
    return Observable(actions)
        .whereType<MemberActionRefresh>()
        .flatMap((action) async* {
      final state = store.state;
      if (state is LoginStateLoggedIn) {
        yield MemberActionLoading();

        final members = await _repository.allMembers(state.loginToken);
        yield MemberActionLoaded(members);
      }
    });
  }
}
