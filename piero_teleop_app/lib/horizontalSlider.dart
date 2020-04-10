import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'glob.dart';


class HorizontalSlider extends StatefulWidget {
  final Socket channel;
  HorizontalSlider({Key key, this.channel}) : super(key : key);
  @override
  _HorizontalSliderState createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider> {
  var sliderValue = 0.0;

  void _sendData() {
    widget.channel.write(linVel);
    widget.channel.write("\n");
    widget.channel.write(angVel);
    widget.channel.write("\t");
  }

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
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
                    quarterTurns: 2,
                    child: CupertinoSlider(
                    min: -0.5,
                    max: 0.5,
                    value: sliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValue = newValue;
                        angVel = roundDouble(sliderValue, 2);
                        _sendData();
                      });
                    },
                    onChangeEnd: (_) {
                      setState(() {
                        sliderValue = 0.0;
                        angVel = 0.0;
                        _sendData();
                      });
                    }
                  ),)
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
        ),
      ),
    );
  }
}
