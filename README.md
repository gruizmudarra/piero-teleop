# Piero Teleop
PIERO is a educational robotics platform developed by researchers and teachers from University of Málaga. As part of a course called "Robotics Lab", we 3D printed the body and build the robot. This project is an extension for what we had to do. 

This project is formed by:
 - An app running on a smartphone functioning as a controller. It's based in the Flutter/Dart toolkit and sends velocity data to the robot using the TCP/IP protocol via WiFi.
 - A ESP8266 microcontroller, used in this case as the WiFi server. The ESP8266 is listening to what data the app sends and resending this same data to the main microcontroller (Arduino Mega 2560) via serial bus.
 - An Arduino Mega 2560 which is the main microcontroller of the robot. It reads the incoming data and with the Inverse Kinematics Model of the robot generates the actuation of the motors that control the wheels.

## TODO
- If TCP server port isn't available, the app won't initiate and only show a black screen. You will have to check if the server is really functioning and restart the app.
- We are aware that the architecture of the project is not optimal. Maybe in the future we will substitute the ESP8266 with a Arduino WiFi Shield.
