import 'package:flutter/material.dart';

class ResistanceScreen extends StatefulWidget {
  @override
  _ResistanceScreenState createState() => _ResistanceScreenState();
}

class _ResistanceScreenState extends State<ResistanceScreen> {
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
    );
  }
}