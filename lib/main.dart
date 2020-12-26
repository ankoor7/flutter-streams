import 'package:flutter/material.dart';
import 'package:work_timer/widgets.dart';

void main() {
  runApp(AppBuilder());
}

class AppBuilder extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      home: AppScaffold(),
      theme: themeData,
    );
  }
}

class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Row presets = Row(children: [
      Expanded(
          child: ProductivityButton(
        color: Colors.teal,
        text: 'Work',
        onPressed: noop,
        size: 150,
      )),
      Expanded(
          child: ProductivityButton(
        color: Colors.lightBlue[600],
        text: 'Short Break',
        onPressed: noop,
        size: 150,
      )),
      Expanded(
          child: ProductivityButton(
        color: Colors.lightBlue[900],
        text: 'Long Break',
        onPressed: noop,
        size: 150,
      )),
    ]);

    final Row actionButtons = Row(children: [
      Expanded(
          child: ProductivityButton(
        color: Colors.black87,
        text: 'Stop',
        onPressed: noop,
        size: 150,
      )),
      Expanded(
          child: ProductivityButton(
        color: Colors.teal,
        text: 'Work',
        onPressed: noop,
        size: 150,
      ))
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
      ),
      body: Column(children: [
        presets,
        Expanded(child: Text('Hello')),
        actionButtons,
      ]),
    );
  }
}

ThemeData themeData = ThemeData(
  primarySwatch: Colors.blueGrey,
);

void noop() {}

LayoutBuilder flexBody = LayoutBuilder(
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
  return SingleChildScrollView(
      child: ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: viewportConstraints.maxHeight,
    ),
    child: const IntrinsicHeight(
      child: Text('Hello World'),
    ),
  ));
});
