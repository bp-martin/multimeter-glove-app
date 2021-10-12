import 'package:flutter/material.dart';

class VoltageScreen extends StatefulWidget {
  @override
  _VoltageScreenState createState() => _VoltageScreenState();
}

class _VoltageScreenState extends State<VoltageScreen> {
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
                    fontSize: 32,
                    color: Color(0xffbe1e1e))),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4),
                    borderRadius: BorderRadius.circular(10)),
                height: 165,
                width: 335,
                margin: EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[Text("Hello"), Text("Hello Again")],
                ))
          ],
        ),
      ),
    );
  }
}
