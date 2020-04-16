/*
  LIBRARIES
*/
#include <ESP8266WiFi.h>

/*
  GLOBAL VARIABLES
*/

WiFiServer wifiServer(80); // Server instance
const char* ssid = "MOVISTAR_48BA";
const char* password = "2094B0CEBB5AB5D2DF58";


// Set your Static IP address
IPAddress local_IP(192, 168, 1, 131);
// Set your Gateway IP address
IPAddress gateway(192, 168, 1, 1);

IPAddress subnet(255, 255, 0, 0);
/*
  CUSTOM FUNCTIONS
*/

// Setup wifi connection
void setup_wifi() {
  // Configures static IP address
  if (!WiFi.config(local_IP, gateway, subnet)) {
    //Serial.println("STA Failed to configure");
  }

  // Connect to Wi-Fi network with SSID and password
  //Serial.print("Connecting to ");
  //Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  //Serial.println("");
  //Serial.println("WiFi connected.");
  //Serial.println("IP address: ");
  //Serial.println(WiFi.localIP());
  //Serial.println(WiFi.macAddress());
  digitalWrite(LED_BUILTIN,HIGH);
  wifiServer.begin();
}

/*
  INITIAL SETUP AND MAIN LOOP
*/

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN,OUTPUT);
  delay(1000);
  setup_wifi();
}

void loop() {
  int l = 0;
  int a = 0;
  String command = ""; // Command received from the app
  bool firstValue = true;
  byte buf[8];
  WiFiClient app = wifiServer.available();

  if (app) {
    //Serial.println("Client connected");
    while (app.connected()) { // While the client is connected (only one client permitted) 
      /***************
       * PARSING MSG * 
       ***************/
       
      while (app.available() > 0) {
        char c = app.read();
//        c.getBytes(buf,8);
//        for(int y = 0; y < 8; y++) {
//          Serial.write(buf[y]);
//          delay(500);
//        }
        Serial.write(c);
        if (c == '\n') {
          if(firstValue) { 
            l = command.toInt();            // casting and saving the command string to a double variable
            firstValue = false;
            command = "";
          }
          else {
              a = command.toInt();          // casting and saving the command string to a double variable
              buf[0] = l;
              buf[1] = a;
              firstValue = true;
//              Serial.printf("Linear: %d\tAngular: %d\n",l,a);
//              Serial.print("\t");
//              Serial.print(l,BIN);
//              Serial.print("\n");
//              Serial.write(l);

//              delay(100);
//              Serial.write(a);
//              delay(100);
              //Serial.write((byte*)&buf, dataLength);
              //Serial.write(command);
              break;
            }
        }
        else{
            command += c;                   // concatenate the received characters to form a string
          }
      }
      
      command = ""; // reset string
      delay(1);
      
      /*******************
       * END PARSING MSG * 
       *******************/
    }
    app.stop();
    //Serial.println("Client disconnected");
  }
}
