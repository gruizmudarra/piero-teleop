import 'package:flutter/material.dart';
import 'homepage.dart';
import 'dart:io';

void main() async {
  Socket s = await Socket.connect('192.168.1.131',80);
  runApp(MyApp(s));
}

class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piero Teleop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ControlPage(
        channel: socket,
      ),
    );
  }
}