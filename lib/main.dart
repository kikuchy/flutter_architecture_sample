import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/architectures/redux/app.dart';
import 'package:flutter_architecture_samples/architectures/scoped_model/app.dart';
import 'package:flutter_architecture_samples/architectures/stateful_widget/app.dart';

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
          _button(context, "StatefulWidget", (context) => StatefulWidgetApp()),
          _button(context, "ScopedModel", (context) => ScopedModelApp()),
          _button(context, "Redux", (context) => ReduxApp()),
        ],
      ),
    );
  }

  RaisedButton _button(BuildContext context, String appName,
      Widget Function(BuildContext) builder) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: builder));
      },
      child: Text(appName),
    );
  }
}
