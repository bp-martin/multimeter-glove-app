import 'package:flutter/material.dart';
import 'dart:async';
import 'choose_measure.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChooseMeasure()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4c748b),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "HOMEBREW",
              style: TextStyle(
                  fontFamily: 'Norwester',
                  fontSize: 48,
                  color: Color(0xffffffff)),
            ),
            Text("Great Coffee at Home",
                style: TextStyle(
                    fontFamily: 'Kollektif',
                    fontSize: 18,
                    color: Color(0xffffffff)))
          ],
        ),
      ),
    );
  }
}
