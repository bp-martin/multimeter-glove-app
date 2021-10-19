#include <WebSocketsServer.h>
#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <DHT.h>
#include <SoftwareSerial.h>

const char *ssid = "Connectify-me";
const char *pass = "kadajuk4"

String json;

WebSocketsServer webSocket = WebSocketsServer(81);

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
  String cmd = "";
  switch(type) {
    case websocket_disconnected:
        Serial.println("Websocket is not connected");
        break;
    case websocket_connected:
        {
          Serial.println("Websocket is connected");
          Serial.println(webSocket.remoteIP(num).toString());
          webSocket.sendTXT(num, "connected");
        }
    case websocket_text:
        cmd = "";
        for (int i = 0; i < length; i++) {
          cmd = cmd + (char)payload[i];
        }
        Serial.println(cmd);

        if (cmd == "readdata"){
        }

        webSocket.sendTXT(num, cmd+":success");
        break;
    case websocket_fragment_text_start:
        break;
    case websocket_fragment_bin_start:
        break;
    case websocket_bin:
        hexdump(payload, length);
        break;
    default:
        break;
}

String charactersToString(char* chr) {
  String rval;
  for(int x = 0; x < strlen(char); x++) {
    rval = rval + char[x];
  }
  return rval;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  Serial.println("Connecting to WiFi");

  IPAddress apIP(192, 168, 0, 1);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP(ssid, pass);

  webSocket.begin();
  webSocket.onEvent(webSocketEvent);
  Serial.println("WebSocket is started");
}

void loop() {
  // put your main code here, to run repeatedly:
  webSocket.loop();

  delay(1000);
}
