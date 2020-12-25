import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
      ),
      body: Center(
        child: Column(
         children: [Text('Hello World')],
        ),
      ),
    );
  }
}

ThemeData themeData = ThemeData(
  primarySwatch: Colors.blueGrey,
);

LayoutBuilder flexBody = LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints)
{
  return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: viewportConstraints.maxHeight,
        ),
        child: const IntrinsicHeight(
          child: Text('Hello World'),
        ),
      )
  );
});
