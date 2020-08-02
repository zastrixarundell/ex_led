#include <ESP8266WiFi.h>
#include <IRremoteESP8266.h>
#include <IRsend.h>

uint32_t transalteCode(String& code)
{
  return strtoul(code.c_str(), NULL, 10);
}

void writeIR(IRsend& irsend, String& code)
{
  irsend.sendNEC(transalteCode(code));
}