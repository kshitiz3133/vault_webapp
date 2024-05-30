import 'dart:async';
import 'package:dash_bubble/dash_bubble.dart';

import 'package:flutter/material.dart';
class VaultHome extends StatefulWidget {
  const VaultHome({Key? key}) : super(key: key);

  @override
  State<VaultHome> createState() => _VaultHomeState();
}

class _VaultHomeState extends State<VaultHome> {
  late Timer _timer;
  bool a=true;
  int _secondsRemaining = 5 * 60; // 5 minutes in seconds
  int currentIconIndex = 0;
  List<String> bubbleIcons = [
    "a", // Replace with your actual icon paths
    "b",
    "c",
    "d",
    "e",
  ];


  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        a=false;
        if (_secondsRemaining > 0) {
          _secondsRemaining--;

          // Check if a minute has passed
          if (_secondsRemaining % 60 == 0) {
            setState(() {
              currentIconIndex = (currentIconIndex + 1) % bubbleIcons.length;
            });
            stopBubble();
            Future.delayed(Duration(milliseconds: 100),(){
              startBubble();
            });
          }
        } else {
          stopTimer();
          // Perform any action when the countdown finishes
          print('Countdown finished');
        }
      });
    });
  }


  void stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      stopBubble();
      setState(() {
        _secondsRemaining = 5 * 60;
        currentIconIndex=0;
        a=true;
      });
    }
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
        title: Text('Vault'),
        leading: a?IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back),):SizedBox(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){startBubble();startTimer();}, child: Text("Activate")),
            Text(
              'Time Remaining:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              formatTime(_secondsRemaining),
              style: TextStyle(fontSize: 48),
            ),
            ElevatedButton(onPressed: (){stopTimer();}, child: Text("Deactivate")),
          ],
        ),
      ),
    );
  }
  Future<void> startBubble() async {
    final isStarted = await DashBubble.instance.startBubble(bubbleOptions: BubbleOptions(
      bubbleIcon: bubbleIcons[currentIconIndex],
      bubbleSize: 50,
      enableClose: false,
      distanceToClose: 90,
      enableAnimateToEdge: true,
      enableBottomShadow: true,
      keepAliveWhenAppExit: false,
    ),);
    if (isStarted == true) {
      print("Permission Granted");
    } else {
      print("Permission Revoked");
    }
  }
  Future<void> stopBubble() async {
    final hasStopped = await DashBubble.instance.stopBubble();
    if (hasStopped == true) {
      print("Bubble Stopped");
    } else {
      print("didnt stop");
    }
  }
}
