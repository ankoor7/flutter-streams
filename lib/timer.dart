import 'dart:async';

import 'package:work_timer/timerModel.dart';

class CountDownTimer {
  double _percentRemaining = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fulltime;
  TimerModel currentTimeModel;
  int work = 45;
  int shortBreak = 5;
  int longBreak = 20;

  void startWork() {
    _percentRemaining = 100;
    _time = Duration(minutes: work, seconds: 0);
    _fulltime = _time;
    startTimer();
  }

  void startBreak(bool isShort) {
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
