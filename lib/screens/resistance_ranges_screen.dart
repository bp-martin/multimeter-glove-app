import 'package:flutter/material.dart';
import 'resistance_screen_r1.dart';
import 'resistance_screen_r2.dart';
import 'resistance_screen_r3.dart';
import 'resistance_screen_r4.dart';
import 'resistance_screen_r5.dart';

class ChooseResistanceRange extends StatefulWidget {
  @override
  _ChooseResistanceRangeState createState() => _ChooseResistanceRangeState();
}

class _ChooseResistanceRangeState extends State<ChooseResistanceRange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
          backgroundColor: Color(0xfff3f3f3),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Color(0xffbe1e1e), size: 18),
              onPressed: () => Navigator.of(context).pop())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Resistance Ranges",
              style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 32,
                  color: Color(0xffbe1e1e)),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
            Text("Choose the range for your resistance:",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff000000))),
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            ElevatedButton(
                child: Text("220Ω"),
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
                          builder: (context) => ResistanceScreenR1()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("2kΩ"),
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
                          builder: (context) => ResistanceScreenR2()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("20kΩ"),
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
                          builder: (context) => ResistanceScreenR3()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("200kΩ"),
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
                          builder: (context) => ResistanceScreenR4()));
                }),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(
                child: Text("2MΩ"),
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
                          builder: (context) => ResistanceScreenR5()));
                }),
          ],
        ),
      ),
    );
  }
}
