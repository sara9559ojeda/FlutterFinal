import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/repositories/websocket_repository_impl.dart';
import 'domain/usecases/connect_websocket.dart';
import 'domain/usecases/disconnect_websocket.dart';
import 'domain/usecases/send_message.dart';
import 'presentation/controllers/websocket_controller.dart';
import 'presentation/pages/control_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // asegúrate que tienes un archivo .env en la raíz

  // 🔌 Inyección de dependencias
  final repo = WebSocketRepositoryImpl();
  Get.put(ConnectWebSocket(repo));
  Get.put(SendMessage(repo));
  Get.put(DisconnectWebSocket(repo));

  // Controlador GetX
  Get.put(WebSocketController(
    connectWebSocket: Get.find(),
    sendMessageUseCase: Get.find(),
    disconnectWebSocket: Get.find(),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Domótica ESP32',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ControlPage(), // 👈 tu página inicial
    );
  }
}
