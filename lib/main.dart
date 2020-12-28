import 'dart:math';

import 'package:flutter/material.dart';
import 'package:work_timer/settings.dart';
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
      home: TimerScreen(),
      theme: themeData,
    );
  }
}

// This is the type used by the popup menu.
enum screens { settings, timer }

void gotoSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<Widget>(builder: (BuildContext context) => SettingsScreen()),
  );
}

class TimerScreen extends StatelessWidget {
  final CountDownTimer countDownTimer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final Row presets = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductivityButton(
          color: Colors.teal,
          text: 'Work',
          onPressed: countDownTimer.startWork,
          size: buttonSize,
        ),
        ProductivityButton(
          color: Colors.lightBlue[600],
          text: 'Short Break',
          onPressed: () => countDownTimer.startBreak(true),
          size: buttonSize,
        ),
        ProductivityButton(
          color: Colors.lightBlue[900],
          text: 'Long Break',
          onPressed: () => countDownTimer.startBreak(false),
          size: buttonSize,
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
          size: buttonSize,
        ),
        ProductivityButton(
          color: Colors.teal,
          text: 'Restart',
          onPressed: countDownTimer.startTimer,
          size: buttonSize,
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
      ),
      floatingActionButton: PopupMenuButton<screens>(
        onSelected: (screens result) {
          if (result == screens.settings) {
            gotoSettings(context);
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<screens>>[
          const PopupMenuItem<screens>(
            value: screens.settings,
            child: Text('Settings'),
          ),
        ],
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
                            (BuildContext context, AsyncSnapshot<
                            TimerModel> snapshot) {
                          final TimerModel timer = snapshot.data ?? TimerModel(
                              '00:00', 1);
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

double buttonSize = 150;

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
