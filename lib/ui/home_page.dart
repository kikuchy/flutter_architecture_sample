import 'package:flutter/material.dart';

import 'member_page.dart';
import 'message_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MemberPage(),
          MessagePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: (_controller.hasClients) ? _controller.page.toInt() : 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text("Members")),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), title: Text("Messages")),
        ],
        onTap: (i) {
          setState(() {
            _controller.jumpToPage(i);
          });
        },
      ),
    );
  }
}
