#include <WebSocketsServer.h>
#include <Arduino.h>
#include <ESP8266WiFi.h>

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
float resistanceValue; 
char rtr[10];

WebSocketsServer webSocket = WebSocketsServer(81);

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

void setup() {
  
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
  
  Serial.print("Sensor from Analogue Pin = ");
  Serial.println(input);

  // Voltage Calculations
  voltageValue = input * (12.4 / 1023.0);
  
  // Resistance Calculations
  voltageOutput = input * (3.3 / 1023.0);
  resistanceValue = (voltageOutput * 2000) / (3.3 - voltageOutput);
  
  delay(1000);

  if(isnan(input))
  {
    Serial.println(F("Failed to read voltage value"));
    return;
  } else {
    sprintf(vtr, "%.4f", voltageValue);
    sprintf(rtr, "%.4f", resistanceValue);

    json = "{'Voltage Value':'" + charactersToString(vtr) + "','Resistance Value':'" + charactersToString(rtr) + "'}";
    Serial.println(json);
    webSocket.broadcastTXT(json);
  }
}
