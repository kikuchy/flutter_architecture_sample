import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/app.dart';

void main() => runApp(AppSwitcher());

class AppSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _AppSwitcherContent(),
    );
  }
}

class _AppSwitcherContent extends StatelessWidget {
  const _AppSwitcherContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScopedModelApp()));
            },
            child: Text("ScopedModel"),
          )
        ],
      ),
    );
  }
}
