#include <ESP8266WiFi.h>
// GLOBAL VARIABLES
WiFiServer wifiServer(80); // Server instance
const char* ssid = "your-ssid";
const char* password = "your-password";
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
  Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  setup_wifi();
}

void loop() {
  String command = ""; // Command received from the app
  char c[4];  // Char array 
  int i = 0; 
  WiFiClient app = wifiServer.available();
  if (app) {
    //Serial.println("Client connected");
    while (app.connected()) { // While the client is connected (only one client permitted)
      while (app.available() > 0) { // While the client speaks
        c[i] = app.read();  // Read from the app and keep in c
          if (c[i] == '\n') {  // If the full message is readed
            for(int y = 0; y < 4; y++) { 
              if (c[y] != NULL){  // If the character is not NULL
                Serial.write(c[y]); // Write the character
                delay(50);
              }
            }
            delay(4*50);
            i = 0;  // Reset i
            for (int j = 0; j < 4; j++){
              c[j] = 0; // Reset c
            }
            break;
          }
          i++;
      }
      delay(5);
    }
    
  }
  app.stop();
  /* Serial.println("Client disconnected"); */ // Debug
}
