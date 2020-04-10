/*
  LIBRARIES
*/
#include <ESP8266WiFi.h>

/*
  GLOBAL VARIABLES
*/

WiFiServer wifiServer(80); // Server instance
const char* ssid = "MiFibra-717C";
const char* password = "n6NAmeCv";


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
    Serial.println("STA Failed to configure");
  }

  // Connect to Wi-Fi network with SSID and password
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  digitalWrite(LED_BUILTIN,HIGH);
  wifiServer.begin();
}

/*
  INITIAL SETUP AND MAIN LOOP
*/

void setup() {
  Serial.begin(115200);
  pinMode(LED_BUILTIN,OUTPUT);
  delay(1000);
  setup_wifi();
}

void loop() {
  double linVel = 0.0; // Linear velocity
  String command = ""; // Command received from the app
  WiFiClient app = wifiServer.available();

  if (app) {
    Serial.println("Client connected");
    while (app.connected()) { // While the client is connected (only one client permitted) 
      /***************
       * PARSING MSG * 
       ***************/
       
      while (app.available() > 0) {
        char c = app.read();
        if (c == '\n') {
          linVel = command.toDouble();  // casting and saving the command string to a double variable
          Serial.printf("Linear: %f \t", linVel);
          break;                        // get out of the while
        }
        command += c;                   // concatenate the received characters to form a string
      }
      command = ""; // reset string
      delay(10);
      
      /*******************
       * END PARSING MSG * 
       *******************/
    }
    app.stop();
    Serial.println("Client disconnected");
  }
}
