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
      backgroundColor: Color(0xff757474),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              "MULTIMETER",
              style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 48,
                  color: Color(0xffffffff)),
            ),
            Text("GLOVE",
                style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 48,
                    color: Color(0xffffffff))),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 290)),
            Text("Stark Team",
                style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xff000000))),
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0))
          ],
        ),
      ),
    );
  }
}
