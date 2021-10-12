import 'package:flutter/material.dart';
import 'voltage_screen.dart';
import 'current_screen.dart';
import 'resistance_screen.dart';
import 'data_screen.dart';

class ChooseMeasure extends StatefulWidget {
  @override
  _ChooseMeasureState createState() => _ChooseMeasureState();
}

class _ChooseMeasureState extends State<ChooseMeasure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
            Text(
              "MULTIMETER GLOVE",
              style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 32,
                  color: Color(0xffbe1e1e)),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),
            Text("What you want to measure?",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff000000))),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            ElevatedButton(
                child: Text("Voltage"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffbe1e1e),
                    onPrimary: Color(0xffffffff),
                    fixedSize: Size(144, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle:
                        TextStyle(fontFamily: 'Montserrat', fontSize: 14)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VoltageScreen()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("Current"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffbe1e1e),
                    onPrimary: Color(0xffffffff),
                    fixedSize: Size(144, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle:
                        TextStyle(fontFamily: 'Montserrat', fontSize: 14)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CurrentScreen()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("Resistance"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffbe1e1e),
                    onPrimary: Color(0xffffffff),
                    fixedSize: Size(144, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle:
                        TextStyle(fontFamily: 'Montserrat', fontSize: 14)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResistanceScreen()));
                }),
            Divider(
                thickness: 1.5,
                color: Color(0xffbe1e1e),
                height: 130,
                indent: 30,
                endIndent: 30),
            Text("Check your saved data:",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff000000))),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("Data"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffbe1e1e),
                    onPrimary: Color(0xffffffff),
                    fixedSize: Size(144, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle:
                        TextStyle(fontFamily: 'Montserrat', fontSize: 14)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DataScreen()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0))
          ],
        ),
      ),
    );
  }
}
