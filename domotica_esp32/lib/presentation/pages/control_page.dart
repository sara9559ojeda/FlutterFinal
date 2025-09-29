import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/websocket_controller.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WebSocketController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Control LED ESP32")),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.status.value,
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.sendMessage("LED_ON"),
                  child: const Text("💡 Encender LED"),
                ),
                ElevatedButton(
                  onPressed: () => controller.sendMessage("LED_OFF"),
                  child: const Text("🌑 Apagar LED"),
                ),
              ],
            )),
      ),
    );
  }
}
