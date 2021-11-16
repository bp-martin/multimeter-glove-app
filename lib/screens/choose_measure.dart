import 'package:flutter/material.dart';
import 'voltage_screen.dart';
import 'current_screen.dart';
import 'resistance_ranges_screen.dart';
import 'data_screen.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class ChooseMeasure extends StatefulWidget {
  @override
  _ChooseMeasureState createState() => _ChooseMeasureState();
}

class _ChooseMeasureState extends State<ChooseMeasure> {
  // Variables for storing measurements
  String voltage = ''; // Voltage
  String resistanceR1 = ''; // Range 1 = 220
  String resistanceR2 = ''; // Range 2 = 2K
  String resistanceR3 = ''; // Range 3 = 20K
  String resistanceR4 = ''; // Range 4 = 200K
  String resistanceR5 = ''; // Range 5 = 2M
  String current = ''; // Current

  // Variables for displaying values
  double voltageDisplay = 0;
  double resistanceR1Display = 0;
  double resistanceR2Display = 0;
  double resistanceR3Display = 0;
  double resistanceR4Display = 0;
  double resistanceR5Display = 0;
  double currentDisplay = 0;

  late IOWebSocketChannel channel;
  bool connected = false;
  bool saveData = false;

  @override
  void initState() {
    connected = false;

    // Initializing Values for measurements
    voltage = "0";
    resistanceR1 = "0";
    resistanceR2 = "0";
    resistanceR3 = "0";
    resistanceR4 = "0";
    resistanceR5 = "0";
    current = "0";

    // Connecting the WebSocket with ESP8266
    Future.delayed(Duration.zero, () async {
      channelconnect();
    });

    super.initState();
  }

  channelconnect() {
    try {
      channel = IOWebSocketChannel.connect("ws://192.168.0.1:81");
      channel.stream.listen((message) {
        print(message);
        setState(() {
          if (message == "connected") {
            connected = true;
          } else if (message.substring(0, 14) == "{'voltageValue") {
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);
            setState(() {
              // Voltage value
              voltage = jsondata["voltageValue"];
              voltageDisplay = double.parse(voltage);

              // Resistance Values
              // Range 1 = 220
              resistanceR1 = jsondata["res220"];
              resistanceR1Display = double.parse(resistanceR1);

              // Range 2 = 2k
              resistanceR2 = jsondata["res2000"];
              resistanceR2Display = double.parse(resistanceR2);

              // Range 3 = 20k
              resistanceR3 = jsondata["res20000"];
              resistanceR3Display = double.parse(resistanceR3);

              // Range 4 = 200k
              resistanceR4 = jsondata["res200000"];
              resistanceR4Display = double.parse(resistanceR4);

              // Range 5 = 2M
              resistanceR5 = jsondata["res2000000"];
              resistanceR5Display = double.parse(resistanceR5);

              // Current Value
            });
          }
        });
      }, onDone: () {
        print("Web Socket is closed");
        setState(() {
          connected = false;
        });
      }, onError: (error) {
        print(error.toString());
      });
    } catch (_) {
      print("Error on connecting to websocket.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VoltageScreen(voltageVal: voltageDisplay)));
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
                          builder: (context) => ChooseResistanceRange()));
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
