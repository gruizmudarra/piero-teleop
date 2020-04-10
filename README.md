## Piero-Teleop
PIERO is a educational robotics platform developed by researchers and teachers from University of Málaga. As part of a course called "Robotics Lab", we 3D printed the body and build the robot. This project is an extension for what we had to do in that project. 

This project is formed by:
 -An app running on a smartphone functioning as a controller. It's based in the Flutter/Dart toolkit and sends velocity data to the robot using the TCP/IP protocol via WiFi.
 -A ESP8266 microcontroller, used in this case as the WiFi server. The ESP8266 is listening to what data the app sends and resending this same data to the main microcontroller (Arduino Mega 2560) via I2C (SPI).
 -A Simulink program loaded in the main microcontroller, which contains the Inverse Kinematics Model of the robot and generates the actuation of the motors that control the wheels of the robot.
