import 'package:flutter/material.dart';
import 'choose_measure.dart';
import 'package:web_socket_channel/io.dart';

class ResistanceScreenR4 extends StatefulWidget {
  @override
  _ResistanceScreenR4State createState() => _ResistanceScreenR4State();
}

class _ResistanceScreenR4State extends State<ResistanceScreenR4> {
  String resistanceR4 = '';
  double resistanceR4Display = 0;

  late IOWebSocketChannel channel;
  bool connected = false;
  bool saveData = false;

  @override
  void initState() {
    connected = false;
    resistanceR4 = "0";

    // Connecting the WebSocket with ESP8266
    Future.delayed(Duration.zero, () async {
      channelconnect();
    });

    super.initState();
  }

  channelconnect() {
    try {
      channel = IOWebSocketChannel.connect("ws://192.168.0.1:81");
      channel.sink.add("range200000");
      channel.stream.listen((message) {
        print(message);
        setState(() {
          resistanceR4 = message;
          resistanceR4Display = double.parse(resistanceR4);
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
              onPressed: () {
                channel.sink.add("empty");
                Navigator.of(context).pop();
              })),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Resistance  (200kΩ)",
                style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 36,
                    color: Color(0xffbe1e1e))),
            Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
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
                            Text("$resistanceR4Display",
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 60,
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
                            Text("Ω",
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
                    primary: Color(0xffe2e2e2),
                    onPrimary: Color(0xff000000),
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
                  channel.sink.add("empty");
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
