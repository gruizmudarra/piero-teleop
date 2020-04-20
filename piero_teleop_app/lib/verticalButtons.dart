import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'glob.dart';

class VerticalButtons extends StatefulWidget {
  final Socket channel;
  VerticalButtons({
    Key key,
    this.channel
  }) : super(key: key);

  @override
  _VerticalButtonsState createState() => _VerticalButtonsState();
}

class _VerticalButtonsState extends State<VerticalButtons> {
  bool _tap1InProgress;
  bool _tap2InProgress;

  _VerticalButtonsState() {
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
  }

  void _send1Data() {
    if (!_tap2InProgress) {
      String l = ((100 * linVel).toInt()).toString();
      widget.channel.write(l + "l");
      widget.channel.write("\n");
      print("Sent: $l l");
    }
  }

  void _stop1Data() {
    if (!_tap2InProgress) {
      widget.channel.write(0.toString() + "l");
      widget.channel.write("\n");
      print("Sent: 0 l");
    }
  }

  void _send2Data() {
    if (!_tap1InProgress) {
      String l = ((-100 * linVel).toInt()).toString();
      widget.channel.write(l + "l");
      widget.channel.write("\n");
      print("Sent: $l l");
    }
  }

  void _stop2Data() {
    if (!_tap1InProgress) {
      widget.channel.write(0.toString() + "l");
      widget.channel.write("\n");
      print("Sent: 0 l");
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
          child: Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    GestureDetector(
                        onTapDown: _tap1Down,
                        onTapUp: _tap1Up,
                        onTap: _on1Tap,
                        onTapCancel: _tap1Cancel,
                        child: new Container(
                            height: 75.0,
                            width: 75.0,
                            //child: Align(
                            child: Material(
                              color: _tap1InProgress
                                  ? Colors.blueGrey
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(75.0),
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
                    ),
                    GestureDetector(
                        onTapDown: _tap2Down,
                        onTapUp: _tap2Up,
                        onTap: _on2Tap,
                        onTapCancel: _tap2Cancel,
                        child: new Container(
                            height: 75.0,
                            width: 75.0,
                            //child: Align(
                            child: Material(
                              color: _tap2InProgress
                                  ? Colors.blueGrey
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(75.0),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new IconButton(
                                      icon: Icon(CupertinoIcons.down_arrow),
                                      onPressed: null)
                                ],
                              ),
                            )))
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    child: Text(
                  "Linear velocity: $linVel",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ],
          )),
        ),
      );
  }
}
