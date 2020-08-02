#include <ArduinoWebsockets.h>
#include <ArduinoJson.h>
#include <IRremoteESP8266.h>
#include <IRsend.h>
#include "IRio.h"

IRsend irsend(D6);


using namespace websockets;

#define STATUS 16

const char* joinTemplate = "{\"topic\":\"controller:%s\",\"event\":\"phx_join\",\"payload\":{\"name\":\"%s\"},\"ref\":0}";

void sendHeartbeat(WebsocketsClient& client)
{
  client.send("{\"topic\":\"phoenix\",\"event\":\"heartbeat\",\"payload\":{},\"ref\":0}");
}

void sendPhoenixJoin(WebsocketsClient& client, const char* deviceId, const char* deviceName)
{
  char result[500];
  sprintf(result, joinTemplate, deviceId, deviceName);
  client.send(result);
}

void onMessageCallback(WebsocketsMessage message)
{
    String text = message.data();

    DynamicJsonDocument doc(400);
    deserializeJson(doc, text);

    String event = doc["event"];
    Serial.print("Got Message from event: ");
    Serial.println(event);

    if (event == "ir_write")
    {
      String code = doc["payload"]["code"];
      writeIR(irsend, code);
    }
}

void onEventsCallback(WebsocketsEvent event, String data)
{
  if(event == WebsocketsEvent::ConnectionOpened)
  {
    Serial.println("Connnection Opened");
    digitalWrite(STATUS, LOW);
  } 
  else if(event == WebsocketsEvent::ConnectionClosed)
  {
    digitalWrite(STATUS, HIGH);
    Serial.println("Connnection closed, reconnecting");
  }
}