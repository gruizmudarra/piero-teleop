// Definición de pines
#define PinDerAv 10       // Pin del motor de la rueda derecha para avanzar
#define PinDerRet 9       // Pin del motor de la rueda derecha para retroceder
#define PinIzqAv 12       // Pin del motor de la rueda izquierda para avanzar
#define PinIzqRet 11      // Pin del motor de la rueda izquierda para retroceder
#define PinEnaDer 8       // Pin del motor de la rueda derecha para enable
#define PinEnaIzq 13      // Pin del motor de la rueda izquierda para enable
#define PinAlimentacion 7 // Pin de alimentación
#define EsperaMotores 50  // Tiempo de espera entre escritura de los datos de los motores

// Variables
String command = "";  // Cadena de caracteres que guarda el dato recibido
char option;          // Caracter que lee del ESP8266
float lin = 0.0;      // 
float ang = 0.0;
int l;
int a;
float R = 0.1047;
int Enable = 255;
float Vr;
float Vl;
int VelDer;
int VelIzq;
uint8_t VelDerAv;
uint8_t VelIzqAv;
uint8_t VelDerRet;
uint8_t VelIzqRet;

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
  while (Serial1.available() > 0) {
    option = Serial1.read();
    if (option == 'l') {
      l = command.toInt();
      Serial.print(" Se ha llegado al final del número: Velocidad Lineal = " + String(l));
      Serial.print("\n");
      command = "";
      break;
    }
    else if(option == 'a'){
      a = command.toInt();
      Serial.print(" Se ha llegado al final del número: Velocidad Angular = " + String(a));
      Serial.print("\n");
      command = "";
      break;
    }
    command += option;
  }
  MCI(l,a);
  delay(5);
}

float mapeo(float x, float in_min, float in_max, long out_min, long out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void MCI(int Velocidad_lineal, int Velocidad_angular){
  lin = Velocidad_lineal/100.0;
  ang = Velocidad_angular/100.0;
  ang = mapeo(ang,0,0.5,0,6.28);
  Serial.print("Lineal: " + String(lin));
  Serial.print("\tAngular: "+ String(ang));
  Serial.print("\n");
  if (lin <= 0.5 & lin >= -0.5 & ang <= 6.28 & ang >= -6.28){
    Vr = lin + (ang*R);
    Vl = lin - (R*ang);
    Serial.print("Velocidad Rueda Derecha (m/s): " + String(Vr));
    Serial.print("\tVelocidad Rueda Izquierda (rad/s): "+ String(Vl));
    Serial.print("\n");
    VelDer = mapeo(Vr,0,1.15,0,255);
    VelIzq = mapeo(Vl,0,1.15,0,255);
    Serial.print("Velocidad Rueda Derecha: " + String(VelDer));
    Serial.print("\tVelocidad Rueda Izquierda: "+ String(VelIzq));
    Serial.print("\n");
            
    if(VelDer >= 0 & VelIzq >= 0) {
      VelDerAv = abs(VelDer);
      VelDerRet = 0;
      VelIzqAv = abs(VelIzq);
      VelIzqRet = 0;
    }
    else if (VelDer >= 0 & VelIzq <= 0) {
      VelDerAv = abs(VelDer);
      VelDerRet = 0;
      VelIzqAv = 0;
      VelIzqRet = abs(VelIzq);
    }
    else if (VelDer <= 0 & VelIzq >= 0) {
      VelDerAv = 0;
      VelDerRet = abs(VelDer);
      VelIzqAv = abs(VelIzq);
      VelIzqRet = 0;
    }
    else if (VelDer <= 0 & VelIzq <= 0) {
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
