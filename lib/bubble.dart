import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dash_bubble/dash_bubble.dart';

class Bubble extends StatefulWidget {
  const Bubble({Key? key}) : super(key: key);

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  String a = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  requestOverlayperm();
                },
                child: Text("Permission"),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  startBubble(
                    bubbleOptions: BubbleOptions(
                      bubbleIcon: a,
                      bubbleSize: 140,
                      enableClose: false,
                      distanceToClose: 90,
                      enableAnimateToEdge: true,
                      enableBottomShadow: true,
                      keepAliveWhenAppExit: false,
                    ),
                    onTap: () {
                      setState(() {
                        a='test';
                      });
                      stopBubble(); // Stop the bubble
                      // Start the bubble again after a short delay
                      Future.delayed(Duration(milliseconds: 100), () {
                        startBubble(bubbleOptions: BubbleOptions(
                          bubbleIcon: a,
                          bubbleSize: 140,
                          enableClose: false,
                          distanceToClose: 90,
                          enableAnimateToEdge: true,
                          enableBottomShadow: true,
                          keepAliveWhenAppExit: false,
                        ),);
                      });
                      logMessage(message: 'Bubble Tapped');
                    },
                  );
                },
                child: Text("On"),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  stopBubble();
                },
                child: Text("Off"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestOverlayperm() async {
    final isGranted = await DashBubble.instance.requestOverlayPermission();
    if (isGranted == true) {
      print("Permission Granted");
    } else {
      print("Permission Revoked");
    }
  }

  Future<void> startBubble({BubbleOptions? bubbleOptions, VoidCallback? onTap}) async {
    final hasStarted = await DashBubble.instance.startBubble(
      bubbleOptions: bubbleOptions,
      onTap: onTap,
    );
    if (hasStarted == true) {
      print("Bubble Started");
    } else {
      print("Not Started");
    }
  }

  logMessage({required String message}) {
    print(message);
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
