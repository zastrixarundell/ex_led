#include <ESP8266WiFi.h>
#include <ArduinoWebsockets.h>
#include "Config.h"
#include "ClientRequests.h"

#define TABLE_LED D6
#define STATUS 16

using namespace websockets;

WebsocketsClient client;

const char* ssid = SSID;
const char* password = PASSWORD;
const char* websocketUrl = WEBSOCKETURL;

const char* deviceId = DEVICE_ID;
const char* deviceName = DEVICE_NAME;

unsigned long lastSent;

void setup()
{
  Serial.begin(115200);
  delay(10);

  pinMode(TABLE_LED, OUTPUT);
  pinMode(STATUS, OUTPUT);
  digitalWrite(STATUS, HIGH);

  // Setting up the code for WiFi
 
  Serial.print("Connecting to ");
  Serial.println(ssid);
 
  WiFi.begin(ssid, password);
  WiFi.softAPdisconnect (true);
 
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.print("WiFi connected at: ");
  Serial.print(WiFi.localIP());

  // Setting up the websocket

  Serial.print("Connecting to websocket server: ");
  Serial.println(websocketUrl);

  client.onMessage(onMessageCallback);
  client.onEvent(onEventsCallback);
  
  client.connect(websocketUrl);

  sendPhoenixJoin(client, deviceId, deviceName);
  lastSent = millis();
}

void (* resetFunc) (void) = 0;

void loop()
{
  
  if(!client.available(true))
    resetFunc();

  if(millis() - lastSent >= 10000)
  {
    sendHeartbeat(client);
    lastSent = millis();
  }
    
  client.poll();
}