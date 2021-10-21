#include <WebSocketsServer.h>
#include <Arduino.h>
#include <ESP8266WiFi.h>

const char *ssid = "MultimeterApp";
const char *pass = "12345678";

String json;

const int analogInPin = A0;
float voltageValue = 0;
float vout;

char vtr[10];

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
  // put your setup code here, to run once:
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
  // put your main code here, to run repeatedly:
  webSocket.loop();
  voltageValue = analogRead(analogInPin);
  vout = voltageValue * (5 /1023.0);

  Serial.print("sensor = ");
  Serial.println(voltageValue);

  delay(1000);

  if(isnan(voltageValue))
  {
    Serial.println(F("Failed to read voltage value"));
    return;
  } else {
    sprintf(vtr, "%.4f", vout);

    json = "{'voltageVal':'" + charactersToString(vtr) + "'}";
    Serial.println(json);
    webSocket.broadcastTXT(json);
  }
}
