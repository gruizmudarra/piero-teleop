import 'package:flutter/material.dart';
import 'dart:math';

//Custom fuction to round to 2 decimals max values
double roundDouble(double value, int nDecimals) {
  double mod = pow(10.0, nDecimals);
  return ((value * mod).round().toDouble() / mod);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderValue = 0.0;
  var sentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        title: Text("Teleop for LabRobPiero32"),
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: Column(children: <Widget>[
          Container(
            child: Align(
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                    width: 350.0,
                    height: 400.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Slider(
                              min: -0.5,
                              max: 0.5,
                              divisions: 50,
                              value: sliderValue,
                              activeColor: Color(0xffff520d),
                              inactiveColor: Colors.blueGrey,
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue = newValue;
                                  sentValue = roundDouble(sliderValue, 2);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              child: Text(
                            "Slider value: $sentValue",
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
          ),
        ]),
      ),
    );
  }
}
