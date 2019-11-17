import 'dart:async';

import 'package:uuid/uuid.dart';

class AccountRepository {
  Future<String> login() {
    return Future.delayed(Duration(seconds: 3), () => "login_token");
  }
}

class MessageRepository {
  final Uuid _uuid = Uuid();

  Stream<String> messages(String loginToken) {
    return Stream.periodic(Duration(milliseconds: 700), (_) => _uuid.v4());
  }
}

class Member {
  final String name;
  final String picture;

  const Member(this.name, this.picture);
}

class MemberRepository {
  static const List<Member> _members = [
    Member("Alice", "https://picsum.photos/200"),
    Member("Bob", "https://picsum.photos/200"),
    Member("Carol", "https://picsum.photos/200"),
    Member("Dave", "https://picsum.photos/200"),
    Member("Ellen", "https://picsum.photos/200"),
    Member("Franc", "https://picsum.photos/200"),
  ];

  Future<List<Member>> allMembers(String loginToken) {
    return Future.delayed(Duration(seconds: 1), () => _members);
  }
}
