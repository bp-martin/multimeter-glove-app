import 'package:flutter/material.dart';
import 'choose_measure.dart';
import 'data.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
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
                "Stored Data",
                style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 32,
                    color: Color(0xffbe1e1e)),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff3f3f3),
                      border: Border.all(color: Color(0xffbe1e1e), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  height: 335,
                  width: 350,
                  margin: EdgeInsets.all(0),
                  child: Column(children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Voltage (V): ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 6),
                      Text("${origin.savedVoltage} V",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Current (I): ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 6),
                      Text("${origin.savedCurrent} A",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Resistance (220Ω): ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 3),
                      Text("${origin.resistanceR1} Ω",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Resistance (2kΩ): ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 4),
                      Text("${origin.resistanceR2} Ω",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Resistance (20kΩ):  ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 3),
                      Text("${origin.resistanceR3} Ω",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Resistance (200kΩ): ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 3),
                      Text("${origin.resistanceR4} Ω",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Divider(
                        thickness: 2,
                        color: Color(0xffbe1e1e),
                        indent: 0,
                        endIndent: 0),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Row(children: <Widget>[
                      Spacer(),
                      Text("Resistance (2MΩ):   ",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(flex: 3),
                      Text("${origin.resistanceR5} Ω",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff000000))),
                      Spacer(),
                    ]),
                  ])),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
              ElevatedButton(
                  child: Text("Done"),
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
                            builder: (context) => ChooseMeasure()));
                  }),
            ])));
  }
}
