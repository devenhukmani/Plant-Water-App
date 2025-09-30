#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

const char* thisSsid = "ESP8266";
const char* thisPassword = "1234567890";
String connectSsid = "";
String connectPassword = "";
bool connected = false;
bool failed = false;

ESP8266WebServer server(3000);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(10);

  WiFi.mode(WIFI_AP); 

  if (WiFi.softAP(thisSsid, thisPassword)) {
    Serial.println("Access Point started");
    Serial.print("SSID: ");
    Serial.println(thisSsid);
    Serial.print("IP Address: ");
    Serial.println(WiFi.softAPIP()); // Get the IP address of the Soft AP
  } else {
    Serial.println("Failed to start Access Point");
  }

  server.on("/gettingWiFiInfo", HTTP_POST, handlePostRequest); // Register POST handler for http://IP:PORT/gettingWiFiInfo
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  // put your main code here, to run repeatedly:
  while(!connected){
    server.handleClient();
    String requestBody = "";
    if (server.hasArg("plain")) { // For raw data, like JSON
      requestBody = server.arg("plain");
      Serial.println(requestBody);
    }
    if(requestBody != "" && requestBody != NULL){
      //JSON of form {"ssid":"asdf","password":"asdf1234"}
      requestBody.replace(" ", "");
      requestBody.replace("\n", "");
      requestBody.replace("{", "");
      requestBody.replace("}", "");
      requestBody.replace("\"","");
      int firstComma = requestBody.indexOf(",");
      String SSID_parse = requestBody.substring(0,firstComma);
      Serial.println(SSID_parse);
      String PWORD_parse = requestBody.substring(firstComma);
      Serial.println(PWORD_parse);
      if(SSID_parse.indexOf("SSID") == -1){
        String hold = PWORD_parse;
        PWORD_parse = SSID_parse;
        SSID_parse = hold;
      }
      PWORD_parse.replace(",", "");
      int colon = SSID_parse.indexOf(":");
      connectSsid = SSID_parse.substring(colon+1);
      Serial.print("SSID found to be: ");
      Serial.println(connectSsid);
      colon = PWORD_parse.indexOf(":");
      connectPassword = PWORD_parse.substring(colon+1);
      Serial.print("Password found to be: ");
      Serial.println(connectPassword);
    }
    if(connectSsid != "" && connectPassword != ""){
        WiFi.mode(WIFI_AP_STA);
        WiFi.begin(connectSsid, connectPassword);
        Serial.println("Connecting");
        int timeCounter = 0;
        while (WiFi.status() != WL_CONNECTED && timeCounter < 60) {
          delay(500);
          Serial.print(".");
          timeCounter ++;
        }
        if(WiFi.status() == WL_CONNECTED){
          server.stop();
          WiFi.mode(WIFI_STA);
          connected = true;
          Serial.println("Connected to " + connectSsid + "!");
          Serial.println("HTTP server stopped");
        }else{
          connectSsid = "";
          connectPassword = "";
          failed = true; //deal with this case
        }
    }
  }
}

void handlePostRequest() {
  if (server.hasArg("plain")) { // For raw data, like JSON
    String requestBody = server.arg("plain");
    Serial.print("Received raw body: ");
    Serial.println(requestBody);
    // You would parse this JSON string here
  }
}