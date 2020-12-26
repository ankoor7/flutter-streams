import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_timer/timer.dart';
import 'package:work_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:work_timer/timerModel.dart';

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
  CountDownTimer countDownTimer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final Row presets = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductivityButton(
          color: Colors.teal,
          text: 'Work',
          onPressed: countDownTimer.startWork,
          size: 150,
        ),
        ProductivityButton(
          color: Colors.lightBlue[600],
          text: 'Short Break',
          onPressed: () => countDownTimer.startBreak(true),
          size: 150,
        ),
        ProductivityButton(
          color: Colors.lightBlue[900],
          text: 'Long Break',
          onPressed: () => countDownTimer.startBreak(false),
          size: 150,
        ),
      ],
    );

    final Row actionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductivityButton(
          color: Colors.black87,
          text: 'Stop',
          onPressed: countDownTimer.stopTimer,
          size: 150,
        ),
        ProductivityButton(
          color: Colors.teal,
          text: 'Restart',
          onPressed: countDownTimer.startTimer,
          size: 150,
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(children: [
              presets,
              StreamBuilder<TimerModel>(
                initialData: TimerModel('00:00', 1),
                stream: countDownTimer.stream(),
                builder:
                    (BuildContext context, AsyncSnapshot<TimerModel> snapshot) {
                  final TimerModel timer = snapshot.data ?? TimerModel('00:00', 1);
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: min(viewportConstraints.maxWidth,
                              viewportConstraints.maxHeight) /
                          2,
                      lineWidth: 10,
                      percent: timer.percent,
                      center: Text(timer.time),
                      progressColor: Colors.teal,
                    ),
                  );
                },
              ),
              actionButtons,
            ]),
          ),
        ));
      }),
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
