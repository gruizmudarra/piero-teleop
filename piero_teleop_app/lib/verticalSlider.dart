import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'glob.dart';

/* TODO: 1. Change the pads
         2. Take the message with the value of the variable and
            put it in a box in the middle of the screen */
class VerticalSlider extends StatefulWidget {
  final Socket channel;
  VerticalSlider({Key key, this.channel}) : super(key : key);

  @override
  _VerticalSliderState createState() => _VerticalSliderState();
}
class _VerticalSliderState extends State<VerticalSlider> {
  var sliderValue = 0.0;

  void _sendData() {
    int l = (100*linVel).toInt();
    int a = (100*angVel).toInt();
    Iterable<int> package = [l, a];
    widget.channel.writeAll(package, "\n");
    widget.channel.write("\n");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Align(
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
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: CupertinoSlider(
                    min: -0.5,
                    max: 0.5,
                    value: sliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValue = newValue;
                        linVel = roundDouble(sliderValue, 2);
                        _sendData();
                      }
                    );
                    }, 
                    onChangeEnd: (_) {
                      setState(() {
                        sliderValue = 0.0;
                        linVel = 0.0;
                        _sendData();
                      });
                    },
                  )
                  )
                ),
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
      ),
    );
  }
}
