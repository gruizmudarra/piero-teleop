import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'glob.dart';

/* TODO: 1. Change the pads
         2. Take the message with the value of the variable and
            put it in a box in the middle of the screen */
class HorizontalButtons extends StatefulWidget {
  final Socket channel;
  HorizontalButtons({
    Key key,
    this.channel
  }) : super(key: key);

  @override
  _HorizontalButtonsState createState() => _HorizontalButtonsState();
}

class _HorizontalButtonsState extends State<HorizontalButtons> {
  bool _tap1InProgress;
  bool _tap2InProgress;

  _HorizontalButtonsState() {
    _tap1InProgress = false;
    _tap2InProgress = false;
  }

  void _tap1Down(TapDownDetails details) {
    setState(() {
      _tap1InProgress = true;
      _send1Data();
    });
  }

  void _tap1Up(TapUpDetails details) {
    setState(() {
      _tap1InProgress = false;
      _stop1Data();
    });
  }

  void _tap1Cancel() {
    setState(() {
      _tap1InProgress = false;
    });
  }

  void _on1Tap() {
    // TODO - actual code you want to run once a tap happens
  }

  void _tap2Down(TapDownDetails details) {
    setState(() {
      _tap2InProgress = true;
      _send2Data();
    });
  }

  void _tap2Up(TapUpDetails details) {
    setState(() {
      _tap2InProgress = false;
      _stop2Data();
    });
  }

  void _tap2Cancel() {
    setState(() {
      _tap1InProgress = false;
    });
  }

  void _on2Tap() {
    // TODO - actual code you want to run once a tap happens
  }

  void _send1Data() {
    if (!_tap2InProgress) {
      String a = ((-100 * angVel).toInt()).toString();
      widget.channel.write(a + "a");
      widget.channel.write("\n");
      print("Sent: $a a");
    }
  }

  void _stop1Data() {
    if (!_tap2InProgress) {
      widget.channel.write(0.toString() + "a");
      widget.channel.write("\n");
      print("Sent: 0 a");
    }
  }

  void _send2Data() {
    if (!_tap1InProgress) {
      String a = ((100 * angVel).toInt()).toString();
      widget.channel.write(a + "a");
      widget.channel.write("\n");
      print("Sent: $a a");
    }
  }

  void _stop2Data() {
    if (!_tap1InProgress) {
      widget.channel.write(0.toString() + "a");
      widget.channel.write("\n");
      print("Sent: 0 a");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTapDown: _tap1Down,
                              onTapUp: _tap1Up,
                              onTap: _on1Tap,
                              onTapCancel: _tap1Cancel,
                              child: new Container(
                                height: 75.0,
                                width: 75.0,
                                child: Material(
                                  color: _tap1InProgress
                                    ? Colors.blueGrey
                                    : Colors.grey,
                                  borderRadius: BorderRadius.circular(35.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new IconButton(
                                        icon: Icon(CupertinoIcons.up_arrow),
                                        onPressed: null)
                                  ],
                                ),
                              ))),
                    ),
                        Expanded(
                          child:GestureDetector(
                            onTapDown: _tap2Down,
                            onTapUp: _tap2Up,
                            onTap: _on2Tap,
                            onTapCancel: _tap2Cancel,
                              child: new Container(
                                height: 75.0,
                                width: 75.0,
                                child: Material(
                                  color: _tap2InProgress
                                    ? Colors.blueGrey
                                    : Colors.grey,
                                  borderRadius: BorderRadius.circular(35.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                    new IconButton(
                                        icon: Icon(CupertinoIcons.up_arrow),
                                        onPressed: null)
                                  ],
                                ),
                              )
                          )
                      )
                    ),
                  ],
                )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    child: Text(
                  "Angular velocity: $angVel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ],
          )),
        );
  }
}
