import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_timer/settings.dart';
import 'package:work_timer/timerModel.dart';

class CountDownTimer {
  CountDownTimer() {
    readSettings();
  }

  double _percentRemaining = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fulltime;
  TimerModel currentTimeModel;
  int work;
  int shortBreak;
  int longBreak;

  Future<void> startWork() async {
    await readSettings();
    _percentRemaining = 100;
    _time = Duration(minutes: work, seconds: 0);
    _fulltime = _time;
    startTimer();
  }

  Future<void> startBreak(bool isShort) async {
    await readSettings();
    _percentRemaining = 100;
    _time = Duration(minutes: isShort ? shortBreak : longBreak, seconds: 0);
    _fulltime = _time;
    startTimer();
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      _isActive = true;
    }
  }

  void stopTimer() {
    _isActive = false;
  }

  Future<void> readSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(WORKTIME)) {
      prefs.setInt(WORKTIME, defaultTimes[WORKTIME]);
    }
    if (!prefs.containsKey(SHORTBREAK)) {
      prefs.setInt(SHORTBREAK, defaultTimes[SHORTBREAK]);
    }
    if (!prefs.containsKey(LONGBREAK)) {
      prefs.setInt(LONGBREAK, defaultTimes[LONGBREAK]);
    }

    work = prefs.getInt(WORKTIME);
    shortBreak = prefs.getInt(SHORTBREAK);
    longBreak = prefs.getInt(LONGBREAK);
  }

  String formatRemainingTime() => "${_time.inMinutes}:${_time.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      if (_isActive) {
        _time = _time - const Duration(seconds: 1);
        _percentRemaining = _time.inSeconds / _fulltime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
        currentTimeModel = TimerModel(formatRemainingTime(), _percentRemaining);
      }

      return currentTimeModel;
    });
  }
}
