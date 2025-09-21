
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8085 });

const interval = 10000;

wss.on('connection', (ws, req) => {
  console.log(` Cliente conectado desde ${req.socket.remoteAddress}`);

  ws.isAlive = true;

  ws.on('pong', () => {
    ws.isAlive = true;
  });

  ws.on('message', (message) => {
    console.log(` Mensaje recibido: ${message}`);

    wss.clients.forEach((client) => {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        client.send(message.toString());
      }
    });
  });

  ws.on('close', () => {
    console.log(' Cliente desconectado');
  });
});

const intervalId = setInterval(() => {
  wss.clients.forEach((ws) => {
    if (ws.isAlive === false) {
      console.log(' Cliente sin respuesta, cerrando...');
      return ws.terminate();
    }

    ws.isAlive = false;
    ws.ping(); 
  });
}, interval);

wss.on('close', () => {
  clearInterval(intervalId);
});

console.log(" Servidor WS escuchando en ws://0.0.0.0:8080");
