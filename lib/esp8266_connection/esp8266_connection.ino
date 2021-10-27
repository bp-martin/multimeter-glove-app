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
char r1tr[10];
char r2tr[10];
char r3tr[10];
float ranges[5]={220,2000,20000,200000,2000000};
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

void resistanceMux1() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, LOW);
}

void resistanceMux2() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);
}

void resistanceMux3() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, HIGH);
  digitalWrite(MUX_A, LOW);
}

//float range1() {
//  resistanceMux1();
//  input = analogRead(analogInPin);
//  voltageOutput = input * (2.2 / 1023.0);
//  resistanceValue = (voltageOutput * 220) / (3.3 - voltageOutput);
//  return resistanceValue;
//}

float range2() {
  resistanceMux2();
  input = analogRead(analogInPin);
  voltageOutput = input * (2.2 / 1023.0);
  resistanceValue = (voltageOutput * 2000) / (3.3 - voltageOutput);
  return resistanceValue;
}

float range3() {
  resistanceMux3();
  input = analogRead(analogInPin);
  voltageOutput = input * (2.2 / 1023.0);
  resistanceValue = (voltageOutput * 20000) / (3.3 - voltageOutput);
  return resistanceValue;
}

String charactersToString(char* chr) {
  String rval;
  for(int x = 0; x < strlen(chr); x++) {
    rval = rval + chr[x];
  }
  return rval;
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

  // Resistance Calculations
  //float range220 = range1();
  float range2000 = range2();
  float range20000 = range3();

  // Operations and send json packages to flutter app
  webSocket.loop();
  
  Serial.print("Sensor from Analogue Pin = ");
  Serial.println(input);

  // Voltage Calculations
  voltageValue = input * (12.4 / 1023.0);
  
  delay(1000);

  for(int i=0;i<6;i++){
    int range=ranges[i];
    switch(range){
      case 220:
        Serial.print("This is 220");
        resistanceMux1();
        input = analogRead(analogInPin);
        voltageOutput = input * (2.2 / 1023.0);
        resistanceValue = (voltageOutput * 220) / (3.3 - voltageOutput);
        //return resistanceValue;
        Serial.print(resistanceValue);
        break;
      case 2000:
        Serial.print("This is 2000");
        break;
      default:
        Serial.print("Out of Range!!");
        break;
      
    }
  }




















  
  if(isnan(input))
  {
    Serial.println(F("Failed to read voltage value"));
    return;
  } else {
    sprintf(vtr, "%.4f", voltageValue);
    //sprintf(r1tr, "%.4f", range220);
    sprintf(r2tr, "%.4f", range2000);
    sprintf(r3tr, "%.4f", range20000);

    json = "{'voltageValue':'" + charactersToString(vtr) + "', 'resistanceValueRange220':'" + "'}";
    Serial.println(json);
    webSocket.broadcastTXT(json);
  }
}
