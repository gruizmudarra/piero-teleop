import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Custom fuction to round to 2 decimals max values
double roundDouble(double value, int nDecimals) {
  double mod = pow(10.0, nDecimals);
  return ((value * mod).round().toDouble() / mod);
}

class VerticalSlider extends StatefulWidget {
  @override
  _VerticalSliderState createState() => _VerticalSliderState();
}
var linVel = 0.0;
class _VerticalSliderState extends State<VerticalSlider> {
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
                    quarterTurns: 3,
                    child: CupertinoSlider(
                    min: -0.5,
                    max: 0.5,
                    value: sliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValue = newValue;
                        linVel = roundDouble(sliderValue, 2);
                      }
                    );
                    }, 
                    onChangeEnd: (_) {
                      setState(() {
                        sliderValue = 0.0;
                        linVel = 0.0;
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
