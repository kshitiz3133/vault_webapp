import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vault_webapp/bankscreen.dart';

class StartAnimation extends StatefulWidget {
  const StartAnimation({Key? key}) : super(key: key);

  @override
  State<StartAnimation> createState() => _StartAnimationState();
}

class _StartAnimationState extends State<StartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigation logic here
        Navigator.pushReplacement(
          context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const BankList(),transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return child;
            },));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Lottie.network(
                "https://lottie.host/f2c0510b-8eee-4553-8d7a-e19ec55afbc6/sHHt2OqMBq.json",
                controller: _animationController,
              ),
            ),
            Text("OTP Verified!",style: TextStyle(fontSize: 20,color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
