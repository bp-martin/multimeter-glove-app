import 'dart:convert';
import 'package:flutter/material.dart';
import 'choose_measure.dart';
import 'package:web_socket_channel/io.dart';

class VoltageScreen extends StatefulWidget {
  @override
  _VoltageScreenState createState() => _VoltageScreenState();
}

class _VoltageScreenState extends State<VoltageScreen> {
  String voltage = '';
  double voltageDisplay = 0;

  late IOWebSocketChannel channel;
  bool connected = false;
  bool saveData = false;

  @override
  void initState() {
    connected = false;
    voltage = "0";
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
          } else if (message.substring(0, 12) == "{'voltageVal") {
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);
            setState(() {
              voltage = jsondata["voltageVal"];
              voltageDisplay = double.parse(voltage);

              if (voltageDisplay > 0.0001) {
                saveData = true;
              } else {
                saveData = false;
              }
            });
          }

          if (voltage == "0") {
            saveData = false;
          } else {
            saveData = true;
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
      appBar: AppBar(
          backgroundColor: Color(0xfff3f3f3),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Color(0xffbe1e1e), size: 18),
              onPressed: () => Navigator.of(context).pop())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Voltage  (V)",
                style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 36,
                    color: Color(0xffbe1e1e))),
            Padding(padding: EdgeInsets.fromLTRB(0, 110, 0, 0)),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4),
                    borderRadius: BorderRadius.circular(10)),
                height: 165,
                width: 335,
                margin: EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                            // Placeholder
                            Text("$voltageDisplay",
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 72,
                                    color: Color(0xff000000))),
                            Divider(
                                thickness: 2,
                                color: Color(0xff000000),
                                indent: 20,
                                endIndent: 10),
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0))
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("V",
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 72,
                                    color: Color(0xff000000))),
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0))
                          ],
                        ))
                  ],
                )),
            Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
            ElevatedButton(
                child: Text("Save Data"),
                style: ElevatedButton.styleFrom(
                    primary: saveData ? Color(0xffe2e2e2) : Color(0xffbe1e1e),
                    onPrimary: saveData ? Color(0xff000000) : Color(0xffffffff),
                    fixedSize: Size(144, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle:
                        TextStyle(fontFamily: 'Montserrat', fontSize: 14)),
                onPressed: () {}),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChooseMeasure()));
                }),
            Spacer()
          ],
        ),
      ),
    );
  }
}
