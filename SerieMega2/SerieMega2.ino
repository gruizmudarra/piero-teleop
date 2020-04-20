// Pins definition
#define PinDerAv 10       // Right wheel motor pin to advance
#define PinDerRet 9       // Right wheel motor pin to advance
#define PinIzqAv 12       // Left wheel motor pin for reverse
#define PinIzqRet 11      // Left wheel motor pin for reverse
#define PinEnaDer 8       // Enable right wheel motor pin
#define PinEnaIzq 13      // Enable left wheel motor pin
#define PinAlimentacion 7 // Power pin
#define EsperaMotores 50  // Waiting time between writing motor data

// Variables
String command = "";  // Character string that stores the received data
char option;          // Character that reads from serial 1
float lin = 0.0;      // Linear speed
float ang = 0.0;      // Angular speed
int l;                // Linear speed 
int a;                // Angular speed
float R = 0.1047;     // Wheel radius
int Enable = 255;     // Motor enable
float Vr;             // Right wheel speed
float Vl;             // Left wheel speed
int VelDer;           // Right wheel speed
int VelIzq;           // Left wheel speed
uint8_t VelDerAv;     // Right wheel speed to advance
uint8_t VelIzqAv;     // Left wheel speed to advance
uint8_t VelDerRet;    // Right wheel speed for reverse
uint8_t VelIzqRet;    // Left wheel speed for reverse

void setup() {
  Serial.begin(115200);
  Serial1.begin(115200);
  pinMode(PinDerAv, OUTPUT);
  pinMode(PinDerRet, OUTPUT);
  pinMode(PinIzqAv, OUTPUT);
  pinMode(PinIzqRet, OUTPUT);
  pinMode(PinEnaDer, OUTPUT);
  pinMode(PinEnaIzq, OUTPUT);
  analogWrite(PinEnaDer,Enable);
  analogWrite(PinEnaIzq,Enable);
  analogWrite(PinAlimentacion,168);
}

void loop() {
  int i = 0;
  while (Serial1.available() > 0) { // While the serial 1 is avialable and the transmissor speaks
    option = Serial1.read();  // Read from the transmissor
    if (option == 'l') {      // If the mesage is linear speed
      l = command.toInt();    // Casting to integer and keep in the variable l
      Serial.print(" Se ha llegado al final del número: Velocidad Lineal = " + String(l));
      Serial.print("\n");
      command = "";           // Reset the String
      break;
    }
    else if(option == 'a'){   // If the mesage is angular speed
      a = command.toInt();    // Casting to integer and keep in the variable a
      Serial.print(" Se ha llegado al final del número: Velocidad Angular = " + String(a));
      Serial.print("\n");
      command = "";           // Reset the String
      break;
    }
    command += option;        // If the message is not finished, the message accumulates
  }
  MCI(l,a);                   // Indirect Kinematic Model calculation
  delay(5);
}


// Function that calculates the interpolation
float mapeo(float x, float in_min, float in_max, long out_min, long out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}


// Function that calculates the Indirect Kinematic Model
void MCI(int Velocidad_lineal, int Velocidad_angular){
  lin = Velocidad_lineal/100.0;
  ang = Velocidad_angular/100.0;
  ang = mapeo(ang,0,0.5,0,3.14);          // The maximum value of the angular speed is pi. Interpolation
  Serial.print("Lineal: " + String(lin));
  Serial.print("\tAngular: "+ String(ang));
  Serial.print("\n");
  if (lin <= 0.5 & lin >= -0.5 & ang <= 3.14 & ang >= -3.14){   // If the velocity values are in the allowed range
    // Indirect Kinematic Model calculation
    Vr = lin + (ang*R);   
    Vl = lin - (R*ang);
    Serial.print("Velocidad Rueda Derecha (m/s): " + String(Vr));
    Serial.print("\tVelocidad Rueda Izquierda (rad/s): "+ String(Vl));
    Serial.print("\n");
    // Interpolation
    VelDer = mapeo(Vr,0,1.15,0,255);  
    VelIzq = mapeo(Vl,0,1.15,0,255);
    Serial.print("Velocidad Rueda Derecha: " + String(VelDer));
    Serial.print("\tVelocidad Rueda Izquierda: "+ String(VelIzq));
    Serial.print("\n");
            
    if(VelDer >= 0 & VelIzq >= 0) {         // If the values are both positives, advance
      VelDerAv = abs(VelDer);
      VelDerRet = 0;
      VelIzqAv = abs(VelIzq);
      VelIzqRet = 0;
    }
    else if (VelDer >= 0 & VelIzq <= 0) {   // If right wheel speed is positive and left wheel speed is negative, turn rigth
      VelDerAv = abs(VelDer);
      VelDerRet = 0;
      VelIzqAv = 0;
      VelIzqRet = abs(VelIzq);
    }
    else if (VelDer <= 0 & VelIzq >= 0) {   // If right wheel speed is negative and left wheel speed is positive, turn left
      VelDerAv = 0;
      VelDerRet = abs(VelDer);
      VelIzqAv = abs(VelIzq);
      VelIzqRet = 0;
    }
    else if (VelDer <= 0 & VelIzq <= 0) { // If the values are both negatives, go back
      VelDerAv = 0;
      VelDerRet = abs(VelDer);
      VelIzqAv = 0;
      VelIzqRet = abs(VelIzq);
    }
    Serial.print("Derecha Avance: " + String(VelDerAv));
    Serial.print("\tDerecha Retroceso: "+ String(VelDerRet));
    Serial.print("\tIzquierda Avance: " + String(VelIzqAv));
    Serial.print("\tIzquierda Retroceso: "+ String(VelIzqRet));
    Serial.print("\n");
    
    // Sending data to the engine pins
    analogWrite(PinDerAv,VelDerAv);
    delay(EsperaMotores);
    analogWrite(PinDerRet,VelDerRet);
    delay(EsperaMotores);
    analogWrite(PinIzqAv, VelIzqAv);
    delay(EsperaMotores);
    analogWrite(PinIzqRet,VelIzqRet);
    delay(EsperaMotores);
  }
  else {
    Vr = 0;
    Vl = 0;
    analogWrite(PinDerAv,Vr);
    delay(EsperaMotores);
    analogWrite(PinDerRet,-Vr);
    delay(EsperaMotores);
    analogWrite(PinIzqAv, Vl);
    delay(EsperaMotores);
    analogWrite(PinIzqRet,-Vl);
    delay(EsperaMotores);
  }
}
