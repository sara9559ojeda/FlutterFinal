const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 8085 });
const interval = 10000; // 10s para revisar clientes

wss.on("connection", (ws, req) => {
  console.log(`✅ Cliente conectado desde ${req.socket.remoteAddress}`);

  ws.isAlive = true;

  // Marcar vivo al recibir pong
  ws.on("pong", () => {
    ws.isAlive = true;
  });

  // Cuando llega un mensaje de cualquier cliente
  ws.on("message", (message) => {
    const msg = message.toString();
    console.log(`📩 Mensaje recibido: ${msg}`);

    // 🔹 Retransmitir el mensaje a todos los demás clientes
    wss.clients.forEach((client) => {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        client.send(msg);
      }
    });
  });

  ws.on("close", () => {
    console.log(" Cliente desconectado");
  });
});

const intervalId = setInterval(() => {
  wss.clients.forEach((ws) => {
    if (ws.isAlive === false) {
      console.log("⚠️ Cliente sin respuesta, cerrando...");
      return ws.terminate();
    }

    ws.isAlive = false;
    ws.ping();
  });
}, interval);

wss.on("close", () => {
  clearInterval(intervalId);
});

console.log("🚀 Servidor WS escuchando en ws://0.0.0.0:8085");
