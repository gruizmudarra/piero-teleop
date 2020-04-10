import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'dart:io';

void main() async {
  Socket puerto = await Socket.connect('192.168.1.131', 80);
  runApp(MyApp(puerto));
}

class MyApp extends StatelessWidget {
  Socket socket;
  MyApp(Socket s) {
    this.socket = s;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      // theme: ThemeData(),
      home: HomePage(channel : socket),
    );
  }
}
