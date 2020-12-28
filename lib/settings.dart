import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_timer/main.dart';
import 'package:work_timer/widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int workTime;
  int shortBreak;
  int longBreak;

  SharedPreferences prefs;

  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 18);

    return Container(
      child: GridView.count(
        childAspectRatio: 3,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Text('Work', style: textStyle),
          Text(''),
          Text(''),
          SettingsButton(
              color: Colors.blueGrey[800],
              text: '-',
              size: buttonSize,
              onPressed: () => updateSettings(WORKTIME, -1)
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(
              color: Colors.teal,
              text: '+',
              size: buttonSize,
              onPressed: () => updateSettings(WORKTIME, 1)
          ),
          Text('Short break', style: textStyle),
          Text(''),
          Text(''),
          SettingsButton(
              color: Colors.blueGrey[800],
              text: '-',
              size: buttonSize,
              onPressed: () => updateSettings(SHORTBREAK, -1)
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(
              color: Colors.teal,
              text: '+',
              size: buttonSize,
              onPressed: () => updateSettings(SHORTBREAK, 1)
          ),
          Text('Long break', style: textStyle),
          Text(''),
          Text(''),
          SettingsButton(
              color: Colors.blueGrey[800],
              text: '-',
              size: buttonSize,
              onPressed: () => updateSettings(LONGBREAK, -1)
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
            focusNode: FocusNode(),
            enableInteractiveSelection: false,
          ),
          SettingsButton(
              color: Colors.teal,
              text: '+',
              size: buttonSize,
              onPressed: () => updateSettings(LONGBREAK, 1)
          ),
        ],
      ),
    );
  }

  Future<void> readSettings() async {
    prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(WORKTIME)) {
      prefs.setInt(WORKTIME, defaultTimes[WORKTIME]);
    }
    if (!prefs.containsKey(SHORTBREAK)) {
      prefs.setInt(SHORTBREAK, defaultTimes[SHORTBREAK]);
    }
    if (!prefs.containsKey(LONGBREAK)) {
      prefs.setInt(LONGBREAK, defaultTimes[LONGBREAK]);
    }

    workTime = prefs.getInt(WORKTIME);
    shortBreak = prefs.getInt(SHORTBREAK);
    longBreak = prefs.getInt(LONGBREAK);

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  Future<void> updateSettings(String key, int value) async {
    int time = prefs.getInt(key);
    time += value;
    if (time > 0) {
      await prefs.setInt(key, time);
      setState(() {
        if (key == WORKTIME) {
          txtWork.text = time.toString();
        }
        if (key == SHORTBREAK) {
          txtShort.text = time.toString();
        }
        if (key == LONGBREAK) {
          txtLong.text = time.toString();
        }
      });
    }
  }
}

const String WORKTIME = 'workTime';
const String SHORTBREAK = 'shortBreak';
const String LONGBREAK = 'longBreak';

Map<String, int> defaultTimes = {
  WORKTIME: 45,
  SHORTBREAK: 5,
  LONGBREAK: 20,
};
