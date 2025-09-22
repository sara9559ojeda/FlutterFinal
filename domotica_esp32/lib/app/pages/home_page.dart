// lib/app/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/websocket_controller.dart';
import '../widgets/led_control_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final wsController = Get.find<WebSocketController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Control ESP32")),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(wsController.status.value, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                LedControlWidget(),
                const SizedBox(height: 20),
                Text("Temperatura: ${wsController.sensorData.value.temperature}°C"),
              ],
            )),
      ),
    );
  }
}
