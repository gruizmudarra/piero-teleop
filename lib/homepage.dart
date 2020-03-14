import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'horizontalSlider.dart';
import 'verticalSlider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            exit(0);
          }),
        title: Text("Teleop for LabRobPiero32"),
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: VerticalSlider()),
            Spacer(),
            Expanded(
              child: HorizontalSlider()),
          ],),
          // Spacer()
        ]),
      ),
    );
  }
}
