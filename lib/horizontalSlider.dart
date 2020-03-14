import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Custom fuction to round to 2 decimals max values
double roundDouble(double value, int nDecimals) {
  double mod = pow(10.0, nDecimals);
  return ((value * mod).round().toDouble() / mod);
}

class HorizontalSlider extends StatefulWidget {
  @override
  _HorizontalSliderState createState() => _HorizontalSliderState();
}
var angVel = 0.0;
class _HorizontalSliderState extends State<HorizontalSlider> {
  var sliderValue = 0.0;
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
                      });
                    },
                    onChangeEnd: (_) {
                      setState(() {
                        sliderValue = 0.0;
                        angVel = 0.0;
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
