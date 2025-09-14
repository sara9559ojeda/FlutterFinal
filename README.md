# 🔌 Proyecto de Domótica con ESP32 + Node.js + Flutter

Este proyecto implementa un sistema de **domótica básica** para controlar luces (LED) desde una aplicación móvil en Flutter, con comunicación **en tiempo real** vía WebSockets.

Incluye:  
- ESP32.  
- Servidor WebSocket en Node.js.  
- Aplicación móvil en Flutter con interfaz amigable.

---

## 🏗️ Arquitectura del sistema

[ ESP32 ] <--WiFi/WebSocket--> [ Servidor Node.js ] <--WebSocket--> [ App Flutter ]
    ↑                                                                 ↓
   LED (GPIO 2)                                                  Usuario (UI)

## ⚙️ Tecnologías utilizadas

- **ESP32** con PlatformIO (Arduino framework).  
- **Node.js** con la librería [`ws`](https://www.npmjs.com/package/ws).  
- **Flutter** con [`web_socket_channel`](https://pub.dev/packages/web_socket_channel).

## 🚀 Instrucciones de uso

### 1. Configuración del ESP32

1. Instalar [VSCode](https://code.visualstudio.com/) + [PlatformIO](https://platformio.org/).  
2. Crear un proyecto con **board** = `esp32dev`.  
3. Editar `src/main.cpp`

### 2. Configuración del Servidor Node.js

Instalar dependencias node:

npm init -y
npm install ws

### 3. iniciar servidor

node server.js

### 4. instalar dependencias flutter
 
flutter pub get