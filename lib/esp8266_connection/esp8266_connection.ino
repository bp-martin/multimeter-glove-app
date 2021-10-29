#include <WebSocketsServer.h>
#include <Arduino.h>
#include <ESP8266WiFi.h>

//GPIO Pins for selecting signal values
#define MUX_C D0
#define MUX_B D1
#define MUX_A D2

// Creating a WiFi red to connect with the Flutter App
const char *ssid = "MultimeterApp";
const char *pass = "12345678";

// Package that will be send to the Flutter App
String json;

// To read the analogue input into the code
const int analogInPin = A0;
float input;

// Voltage Variables
float voltageValue;
char vtr[10];

// Resistance Variables
float voltageOutput;
float resistanceValue;
float res220;
char r1tr[10];
float res2000;
char r2tr[10];
float res20000;
char r3tr[10];
float res200000;
char r4tr[10];
float res2000000;
char r5tr[10];


// First bracket: Row ; Second bracket: Column
float ranges[3][5] = {{220,2000,20000,200000,2000000}, {0,0,0,0,0}, {0,0,0,0,0}};

WebSocketsServer webSocket = WebSocketsServer(81);

void resistanceRange220() {
    digitalWrite(MUX_C, LOW);
    digitalWrite(MUX_B, LOW);
    digitalWrite(MUX_A, LOW);
}

void resistanceRange2000() {
    digitalWrite(MUX_C, LOW);
    digitalWrite(MUX_B, LOW);
    digitalWrite(MUX_A, HIGH);
}

void resistanceRange20000() {
    digitalWrite(MUX_C, LOW);
    digitalWrite(MUX_B, HIGH);
    digitalWrite(MUX_A, LOW);
}

void resistanceRange200000() {
    digitalWrite(MUX_C, LOW);
    digitalWrite(MUX_B, HIGH);
    digitalWrite(MUX_A, HIGH);
}

void resistanceRange2000000() {
    digitalWrite(MUX_C, HIGH);
    digitalWrite(MUX_B, LOW);
    digitalWrite(MUX_A, LOW);
}

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
  String cmd = "";
  switch(type) {
    case WStype_DISCONNECTED:
        Serial.println("Websocket is not connected");
        break;
    case WStype_CONNECTED:
        {
          Serial.println("Websocket is connected");
          Serial.println(webSocket.remoteIP(num).toString());
          webSocket.sendTXT(num, "connected");
        }
    case WStype_TEXT:
        cmd = "";
        for (int i = 0; i < length; i++) {
          cmd = cmd + (char)payload[i];
        }
        Serial.println(cmd);

        if (cmd == "readdata"){
        }

        webSocket.sendTXT(num, cmd);
        break;
    case WStype_FRAGMENT_TEXT_START:
        break;
    case WStype_FRAGMENT_BIN_START:
        break;
    case WStype_BIN:
        hexdump(payload, length);
        break;
    default:
        break;
  }
}

String charactersToString(char* chr) {
  String rval;
  for(int x = 0; x < strlen(chr); x++) {
    rval = rval + chr[x];
  }
  return rval;
}

float rangeFinder() {
  float minValue;

  for (int i = 0; i < 5; i++) {
    
  }
}

void setup() {

  // Defining GPIO pins for Resistance MUX
  pinMode(MUX_C, OUTPUT);
  pinMode(MUX_B, OUTPUT);
  pinMode(MUX_A, OUTPUT);
  
  // Creating the connection of WebSocket; this code runs only once
  Serial.begin(115200);

  Serial.println("Connecting to WiFi");

  IPAddress apIP(192, 168, 0, 1);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP(ssid, pass);

  webSocket.begin();
  webSocket.onEvent(webSocketEvent);
  Serial.println("WebSocket is started");
}

void loop() {

  // Operations and send json packages to flutter app
  webSocket.loop();

  input = analogRead(analogInPin);
  Serial.print("Sensor: ");
  Serial.println(input);

  // Voltage Calculations
  //voltageValue = input * (15.60 / 1023.0);

  voltageValue = input * (3.3 / 1023.0);

  Serial.print("voltage: ");
  Serial.println(voltageValue);

  //input = analogRead(analogInPin);
  //float voutcurrent = input * (5 / 1023.0);
  //Serial.print("Voltage: ");
  //Serial.println(voutcurrent);
  
  
  delay(1000);

  /*for(int i = 0; i < 5; i++) {
    int range = ranges[0][i];
    switch(range){
      // Case for the 220 ohms range
      case 220:
        
        // Selecting the range on MUX
        resistanceRange220();
        
        // Voltage at node D from Wheatstone Bridge
        voltageOutput = input * (3.3 / 1023.0);
        
        // Storing the voltage at node D in an array
        ranges[1][0] = voltageOutput;

        // Value of R4 calculated
        resistanceValue = (voltageOutput * 220) / (3.3 - voltageOutput);
        res220 = resistanceValue;

        Serial.print("This is 220 ohms range: ");
        Serial.println(resistanceValue);
        Serial.print("Voltage at Node D for 220 ohms range: ");
        Serial.println(voltageOutput);
        Serial.print("Sensor Value from Analogue Pin = ");
        Serial.println(input);
        Serial.println();
        break;

      // Case for the 2,000 ohms range
      case 2000:
        // Selecting the range on MUX
        resistanceRange2000();

        // Analog read from pin A0
        //input = analogRead(analogInPin);
        
        // Voltage at node D from Wheatstone Bridge
        voltageOutput = input * (3.3 / 1023.0);

        // Storing the voltage at node D in an array
        ranges[1][1] = voltageOutput;

        // Value of R4 calculated
        resistanceValue = (voltageOutput * 2000) / (3.3 - voltageOutput);
        res2000 = resistanceValue;

        Serial.print("This is 2,000 ohms range: ");
        Serial.println(resistanceValue);
        Serial.print("Voltage at Node D for 2,000 ohms range: ");
        Serial.println(voltageOutput);
        Serial.print("Sensor Value from Analogue Pin = ");
        Serial.println(input);
        Serial.println();
        break;

      // Case for the 20,000 ohms range
      case 20000:
        // Selecting the range on MUX
        resistanceRange20000();

        // Analog read from pin A0
        //input = analogRead(analogInPin);
        
        // Voltage at node D from Wheatstone Bridge
        voltageOutput = input * (3.3 / 1023.0);

        // Storing the voltage at node D in an array
        ranges[1][2] = voltageOutput;

        // Value of R4 calculated
        resistanceValue = (voltageOutput * 20000) / (3.3 - voltageOutput);
        res20000 = resistanceValue;
        
        Serial.print("This is 20,000 ohms range: ");
        Serial.println(resistanceValue);
        Serial.print("Voltage at Node D for 20,000 ohms range: ");
        Serial.println(voltageOutput);
        Serial.print("Sensor Value from Analogue Pin = ");
        Serial.println(input);
        Serial.println();
        break;

      // Case for the 200,000 ohms range
      case 200000:
        // Selecting the range on MUX
        resistanceRange200000();

        // Analog read from pin A0
        //input = analogRead(analogInPin);
        
        // Voltage at node D from Wheatstone Bridge
        voltageOutput = input * (3.3 / 1023.0);

        // Storing the voltage at node D in an array
        ranges[1][3] = voltageOutput;

        // Value of R4 calculated
        resistanceValue = (voltageOutput * 200000) / (3.3 - voltageOutput);
        res200000 = resistanceValue;

        Serial.print("This is 200,000 ohms range: ");
        Serial.println(resistanceValue);
        Serial.print("Voltage at Node D for 200,000 ohms range: ");
        Serial.println(voltageOutput);
        Serial.print("Sensor Value from Analogue Pin = ");
        Serial.println(input);
        Serial.println();
        break;

      // Case for the 2,000,000 ohms range
      case 2000000:
        // Selecting the range on MUX
        resistanceRange2000000();

        // Analog read from pin A0
        //input = analogRead(analogInPin);
        
        // Voltage at node D from Wheatstone Bridge
        voltageOutput = input * (3.3 / 1023.0);

        // Storing the voltage at node D in an array
        ranges[1][4] = voltageOutput;

        // Value of R4 calculated
        resistanceValue = (voltageOutput * 2000000) / (3.3 - voltageOutput);
        res2000000 = resistanceValue;

        Serial.print("This is 2,000,000 ohms range: ");
        Serial.println(resistanceValue);
        Serial.print("Voltage at Node D for 2,000,000 ohms range: ");
        Serial.println(voltageOutput);
        Serial.print("Sensor Value from Analogue Pin = ");
        Serial.println(input);
        Serial.println();
        break;
      default:
        //Serial.print("Out of Range!!");
        break;
    }
  }*/
  
  if(isnan(input))
  {
    Serial.println(F("Failed to read voltage value"));
    return;
  } else {
    sprintf(vtr, "%.2f", voltageValue);
    sprintf(r1tr, "%.2f", res220);
    sprintf(r2tr, "%.2f", res2000);
    sprintf(r3tr, "%.2f", res20000);
    sprintf(r4tr, "%.2f", res200000);
    sprintf(r5tr, "%.2f", res2000000);
    

    json = "{'voltageValue':'" + charactersToString(vtr) + "','range220':'" + charactersToString(r1tr) + "','range2000':'" + charactersToString(r2tr) + "','range20000':'" + charactersToString(r3tr) + "','range200000':'" + charactersToString(r4tr) + "','range2000000':'" + charactersToString(r5tr) + "'}";
    Serial.println(json);
    webSocket.broadcastTXT(json);
  }
}
