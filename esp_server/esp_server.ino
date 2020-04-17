#include <ESP8266WiFi.h>
// GLOBAL VARIABLES
WiFiServer wifiServer(80); // Server instance
const char* ssid = "MOVISTAR_48BA";
const char* password = "2094B0CEBB5AB5D2DF58";
// Set your Static IP address
IPAddress local_IP(192, 168, 1, 131);
// Set your Gateway IP address
IPAddress gateway(192, 168, 1, 1);
// Set your subnet mask
IPAddress subnet(255, 255, 0, 0);

// CUSTOM FUNCTIONS
void setup_wifi() { // Setup wifi connection
  // Configures static IP address
  if (!WiFi.config(local_IP, gateway, subnet)) {
    /* Serial.println("STA Failed to configure"); */
  }
  // Connect to Wi-Fi network with SSID and password
  /*
    Serial.print("Connecting to ");
    Serial.println(ssid);
  */
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  /*
    Serial.println("");
    Serial.println("WiFi connected.");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    Serial.println(WiFi.macAddress());
    digitalWrite(LED_BUILTIN,HIGH);
  */
  wifiServer.begin();
}

// INITIAL SETUP AND MAIN LOOP
void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  setup_wifi();
}

void loop() {
  int l = 0;
  int a = 0;
  String command = ""; // Command received from the app
  WiFiClient app = wifiServer.available();
  if (app) {
    //Serial.println("Client connected");
    while (app.connected()) { // While the client is connected (only one client permitted)
      while (app.available() > 0) { // While the client speaks
        char c = app.read();
        Serial.write(c); // Send caracther through serial connection as it comes
        if (c == 'l') {
          l = command.toInt();    // casting and saving the command string to an integer variable
          /* Serial.printf("Linear: %d\tAngular: %d\n", l, a); */ // Debug
          command = "";
        }
        if (c == 'a') {
          a = command.toInt();    // casting and saving the command string to an integer variable
          /* Serial.printf("Linear: %d\tAngular: %d\n", l, a); */ // Debug
          command = "";
        }
        command += c;   // concatenate the received characters to form a string
      }
    }
    delay(1);
  }
  app.stop();
  /* Serial.println("Client disconnected"); */ // Debug
}
