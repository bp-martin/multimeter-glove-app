#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <WebSocketsServer.h>

// GPIO Pins for Props and Output MUX Pins
#define MUX_C D0
#define MUX_B D1
#define MUX_A D2

// GPIO Pins for Resistance Ranges MUX Pins
#define RMUX_C D5
#define RMUX_B D6
#define RMUX_A D7

// Creating a WiFi connection for the Flutter App
const char *ssid = "MultimeterApp";
const char *pass = "12345678";

ESP8266WebServer server(80);
WebSocketsServer webSocket = WebSocketsServer(81);

// To read the analogue input into the code
const int analogInPin = A0;
float input;

// Global Variables
float voltageValue;         // Voltage Value
float voltageOutput;        // Voltage at Node D for Resistance Circuit
float resistanceValue;      // Resistance Value
float currentValue;         // Current Value
String operation = "";      // Button Selector

// Function for Voltage Circuit
void voltageFunction() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, LOW);

  input = analogRead(analogInPin);
  Serial.print("Sensor: ");
  Serial.println(input);

  // Voltage Calculation
  voltageValue = (input * (3.3 / 1023.0)) * 6.8;

  Serial.print("Voltage: ");
  Serial.println(voltageValue);

  delay(700);

  // Conversion from float to string
  String payload = String(voltageValue, 2);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Current Circuit
void currentFunction() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, HIGH);
  digitalWrite(MUX_A, LOW);

  input = analogRead(analogInPin);
  Serial.print("Sensor: ");
  Serial.println(input);

  // Current Calculation
  currentValue = ((input * (3.3 / 1023.0)) * 1) / 3.3;

  Serial.print("Current: ");
  Serial.println(currentValue);

  delay(700);

  // Conversion from float to string
  String payload = String(currentValue, 3);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Resistance Circuit: Range of 220 Ohms
void resistancer1Function() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);

  digitalWrite(RMUX_C, LOW);
  digitalWrite(RMUX_B, LOW);
  digitalWrite(RMUX_A, LOW);

  input = analogRead(analogInPin);

  // Voltage at node D from Wheatstone Bridge
  voltageOutput = input * (3.3 / 1023.0);

  // Value of R4 calculated
  resistanceValue = (voltageOutput * 275) / (3.3 - voltageOutput);
  
  Serial.print("Missing Resistor Value: ");
  Serial.println(resistanceValue);
  Serial.print("Voltage at Node D: ");
  Serial.println(voltageOutput);
  Serial.print("Sensor Value: ");
  Serial.println(input);
  Serial.println();

  delay(700);

  // Conversion from float to string
  String payload = String(resistanceValue, 0);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Resistance Circuit: Range of 2,000 Ohms
void resistancer2Function() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);

  digitalWrite(RMUX_C, LOW);
  digitalWrite(RMUX_B, LOW);
  digitalWrite(RMUX_A, HIGH);

  input = analogRead(analogInPin);

  // Voltage at node D from Wheatstone Bridge
  voltageOutput = input * (3.3 / 1023.0);

  // Value of R4 calculated
  resistanceValue = (voltageOutput * 1800) / (3.3 - voltageOutput);
  
  Serial.print("Missing Resistor Value: ");
  Serial.println(resistanceValue);
  Serial.print("Voltage at Node D: ");
  Serial.println(voltageOutput);
  Serial.print("Sensor Value: ");
  Serial.println(input);
  Serial.println();

  delay(700);

  // Conversion from float to string
  String payload = String(resistanceValue, 0);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Resistance Circuit: Range of 20,000 Ohms
void resistancer3Function() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);

  digitalWrite(RMUX_C, LOW);
  digitalWrite(RMUX_B, HIGH);
  digitalWrite(RMUX_A, LOW);

  input = analogRead(analogInPin);

  // Voltage at node D from Wheatstone Bridge
  voltageOutput = input * (3.3 / 1023.0);

  // Value of R4 calculated
  resistanceValue = (voltageOutput * 17745) / (3.3 - voltageOutput);
  
  Serial.print("Missing Resistor Value: ");
  Serial.println(resistanceValue);
  Serial.print("Voltage at Node D: ");
  Serial.println(voltageOutput);
  Serial.print("Sensor Value: ");
  Serial.println(input);
  Serial.println();

  delay(700);

  // Conversion from float to string
  String payload = String(resistanceValue, 0);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Resistance Circuit: Range of 200,000 Ohms
void resistancer4Function() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);

  digitalWrite(RMUX_C, LOW);
  digitalWrite(RMUX_B, HIGH);
  digitalWrite(RMUX_A, HIGH);

  input = analogRead(analogInPin);

  // Voltage at node D from Wheatstone Bridge
  voltageOutput = input * (3.3 / 1023.0);

  // Value of R4 calculated
  resistanceValue = (voltageOutput * 200000) / (3.3 - voltageOutput);
  
  Serial.print("Missing Resistor Value: ");
  Serial.println(resistanceValue);
  Serial.print("Voltage at Node D: ");
  Serial.println(voltageOutput);
  Serial.print("Sensor Value: ");
  Serial.println(input);
  Serial.println();

  delay(700);

  // Conversion from float to string
  String payload = String(resistanceValue, 0);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for Resistance Circuit: Range of 2,000,000 Ohms
void resistancer5Function() {
  digitalWrite(MUX_C, LOW);
  digitalWrite(MUX_B, LOW);
  digitalWrite(MUX_A, HIGH);

  digitalWrite(RMUX_C, HIGH);
  digitalWrite(RMUX_B, LOW);
  digitalWrite(RMUX_A, LOW);

  input = analogRead(analogInPin);

  // Voltage at node D from Wheatstone Bridge
  voltageOutput = input * (3.3 / 1023.0);

  // Value of R4 calculated
  resistanceValue = (voltageOutput * 2000000) / (3.3 - voltageOutput);
  
  Serial.print("Missing Resistor Value: ");
  Serial.println(resistanceValue);
  Serial.print("Voltage at Node D: ");
  Serial.println(voltageOutput);
  Serial.print("Sensor Value: ");
  Serial.println(input);
  Serial.println();

  delay(700);

  // Conversion from float to string
  String payload = String(resistanceValue, 0);

  // Send the data to Flutter App
  webSocket.broadcastTXT(payload);
}

// Function for setting up the WebSocket
void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
  String cmd;
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
        operation = cmd;

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

void setup() {

  // GPIO pins for Props and Output MUX
  pinMode(MUX_C, OUTPUT);
  pinMode(MUX_B, OUTPUT);
  pinMode(MUX_A, OUTPUT);

  // GPIO pins for Resistance Ranges MUX
  pinMode(RMUX_C, OUTPUT);
  pinMode(RMUX_B, OUTPUT);
  pinMode(RMUX_A, OUTPUT);
  
  // Creating the connection of WebSocket; this code runs only once
  Serial.begin(115200);
  Serial.println("Connecting to WiFi");

  IPAddress apIP(192, 168, 0, 1);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP(ssid, pass);

  webSocket.begin();
  webSocket.onEvent(webSocketEvent);
  Serial.println("WebSocket is started");

  server.on("/", []() {
        // send index.html
        server.send(200, "text/html", "<html><head><script>var connection = new WebSocket('ws://'+location.hostname+':81/', ['arduino']);connection.onopen = function () {  connection.send('Connect ' + new Date()); }; connection.onerror = function (error) {    console.log('WebSocket Error ', error);};connection.onmessage = function (e) {  console.log('Server: ', e.data);};function sendRGB() {  var r = parseInt(document.getElementById('r').value).toString(16);  var g = parseInt(document.getElementById('g').value).toString(16);  var b = parseInt(document.getElementById('b').value).toString(16);  if(r.length < 2) { r = '0' + r; }   if(g.length < 2) { g = '0' + g; }   if(b.length < 2) { b = '0' + b; }   var rgb = '#'+r+g+b;    console.log('RGB: ' + rgb); connection.send(rgb); }</script></head><body>LED Control:<br/><br/>R: <input id=\"r\" type=\"range\" min=\"0\" max=\"255\" step=\"1\" oninput=\"sendRGB();\" /><br/>G: <input id=\"g\" type=\"range\" min=\"0\" max=\"255\" step=\"1\" oninput=\"sendRGB();\" /><br/>B: <input id=\"b\" type=\"range\" min=\"0\" max=\"255\" step=\"1\" oninput=\"sendRGB();\" /><br/></body></html>");
  });

  server.begin();
}

void loop() {

  // WebSocket started + retrieving from client
  webSocket.loop();
  server.handleClient();

  // Selecting the button from Flutter App
  if (operation == "voltage") {
    voltageFunction();
  } else if(operation == "current") {
    currentFunction();
  } else if(operation == "range220") {
    resistancer1Function();
  } else if(operation == "range2000") {
    resistancer2Function();
  } else if(operation == "range20000") {
    resistancer3Function();
  } else if(operation == "range200000") {
    resistancer4Function();
  } else if(operation == "range2000000") {
    resistancer5Function();
  }
}
