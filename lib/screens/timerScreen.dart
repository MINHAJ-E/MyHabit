import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  bool _isActive = false;
  DateTime _startTime = DateTime.now();

  String getFormattedTime() {
    Duration difference = DateTime.now().difference(_startTime);
    int seconds = difference.inSeconds;
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    seconds = seconds % 60;
    minutes = minutes % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _isActive = true;
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _isActive = false;
    _timer.cancel();
  }

  void _resetTimer() {
    _isActive = false;
    _timer.cancel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Beautiful Clock'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getFormattedTime(),
              style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isActive ? null : _startTimer,
                  child: Text('Start', style: TextStyle(fontSize: 18.0)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isActive ? _stopTimer : null,
                  child: Text('Stop', style: TextStyle(fontSize: 18.0)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset', style: TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // cancel the timer when the widget is disposed
    super.dispose();
  }
}
