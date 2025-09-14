#include <WiFi.h>
#include <WebSocketsClient.h>

const char* ssid = "DOMINAR";
const char* password = "GL56373703";

WebSocketsClient webSocket;

#define LED_PIN 2 

void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
  switch(type) {
    case WStype_DISCONNECTED:
      Serial.println(" Desconectado del servidor");
      break;
    case WStype_CONNECTED:
      Serial.println(" Conectado al servidor WebSocket");
      webSocket.sendTXT("ESP32 listo");
      break;
    case WStype_TEXT:
      Serial.printf(" Mensaje recibido: %s\n", payload);
      if (strcmp((char*)payload, "LED_ON") == 0) {
        digitalWrite(LED_PIN, HIGH);
        Serial.println(" LED ENCENDIDO");
      } else if (strcmp((char*)payload, "LED_OFF") == 0) {
        digitalWrite(LED_PIN, LOW);
        Serial.println(" LED APAGADO");
      }
      break;
  }
}

void setup() {
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT);

  WiFi.begin(ssid, password);
  Serial.println("Conectando a WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\n WiFi conectado");

 
  webSocket.begin("192.168.1.11", 8080, "/");
  webSocket.onEvent(webSocketEvent);
  webSocket.setReconnectInterval(5000);
}

void loop() {
  webSocket.loop();
}
