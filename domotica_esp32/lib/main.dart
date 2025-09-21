import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Domótica ESP32',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ControlPage(),
    );
  }
}

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late WebSocketChannel channel;
  String status = "🟡 Conectando...";

  @override
  void initState() {
    super.initState();

    // Cambia la IP por la de tu servidor WebSocket o ESP32
    channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.9:8085'),
    );

    // Escuchar mensajes entrantes y cambios de estado
    channel.stream.listen(
      (message) {
        setState(() {
          status = "📥 Recibido: $message";
        });
      },
      onDone: () {
        setState(() {
          status = "🔴 Desconectado";
        });
      },
      onError: (error) {
        setState(() {
          status = "⚠️ Error de conexión";
        });
      },
    );

    // Estado inicial de conexión
    setState(() {
      status = "🟢 Conectado";
    });
  }

  void _sendMessage(String message) {
    channel.sink.add(message);
    setState(() {
      status = "📤 Enviado: $message";
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Control LED ESP32")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendMessage("LED_ON"),
              child: const Text("💡 Encender LED"),
            ),
            ElevatedButton(
              onPressed: () => _sendMessage("LED_OFF"),
              child: const Text("🌑 Apagar LED"),
            ),
          ],
        ),
      ),
    );
  }
}
