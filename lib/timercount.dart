import 'package:flutter/material.dart';
import 'dart:async';
class TimerExample extends StatefulWidget {
  @override
  _TimerExampleState createState() => _TimerExampleState();
}

class _TimerExampleState extends State<TimerExample> {
  late Timer _timer;
  int _secondsRemaining = 5 * 60; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          // Perform any action when the countdown finishes
          print('Countdown finished');
        }
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){    startTimer();}, child: Text("start")),
            Text(
              'Time Remaining:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              formatTime(_secondsRemaining),
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
