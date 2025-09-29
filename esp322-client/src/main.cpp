#include <WiFi.h>
#include <WebSocketsClient.h>

const char* ssid = "wifi";       // 🔹 Cambia por tu red
const char* password = "clave";   // 🔹 Cambia por tu clave

WebSocketsClient webSocket;

#define LED_PIN 2  // LED interno ESP32

void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
  switch(type) {
    case WStype_DISCONNECTED:
      Serial.println("❌ Desconectado del servidor");
      break;

    case WStype_CONNECTED:
      Serial.println("✅ Conectado al servidor WebSocket");

      // 👇 Aquí el ESP32 se identifica ante el servidor
      webSocket.sendTXT("CLIENT:ESP32");

      // Y también puede enviar un mensaje de estado inicial
      webSocket.sendTXT("ESP32 listo 🚀");
      break;

    case WStype_TEXT:
      Serial.printf("📩 Mensaje recibido: %s\n", payload);

      if (strcmp((char*)payload, "LED_ON") == 0) {
        digitalWrite(LED_PIN, HIGH);
        Serial.println("💡 LED ENCENDIDO");
      } else if (strcmp((char*)payload, "LED_OFF") == 0) {
        digitalWrite(LED_PIN, LOW);
        Serial.println("💡 LED APAGADO");
      }
      break;

    case WStype_PING:
      Serial.println("📡 Ping recibido");
      break;

    case WStype_PONG:
      Serial.println("📡 Pong recibido (heartbeat OK)");
      break;
  }
}

void setup() {
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT);

  // 🔹 Conectar a WiFi
  Serial.printf("Conectando a %s", ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.printf("\n✅ WiFi conectado. IP: %s\n", WiFi.localIP().toString().c_str());

  // 🔹 Conectar al WebSocket
  webSocket.begin("192.168.1.7", 8085, "/"); // IP de tu servidor Node
  webSocket.onEvent(webSocketEvent);
  webSocket.setReconnectInterval(5000);

  // 🔹 Activar pings automáticos (heartbeat) hacia el servidor
  webSocket.enableHeartbeat(15000, 3000, 2); 
}

void loop() {
  webSocket.loop();
}
