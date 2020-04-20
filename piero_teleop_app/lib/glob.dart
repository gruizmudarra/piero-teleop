/*
* THIS FILE CONTAINS ALL THE CUSTOM FUNCTIONS AND VARIABLES THAT ARE GLOBAL
* THROUGH THE PROJECT
*/

import 'dart:math';

// Custom function to round to 2 decimals max values
double roundDouble(double value, int nDecimals) {
  double mod = pow(10.0, nDecimals);
  return ((value * mod).round().toDouble() / mod);
}

// Global variables sent via TCP/IP connection
String linVelInput;
String angVelInput;
var linVel = 0.0;
var angVel = 0.0;