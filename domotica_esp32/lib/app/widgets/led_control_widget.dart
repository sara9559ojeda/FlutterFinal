// lib/app/widgets/led_control_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/websocket_controller.dart';

class LedControlWidget extends StatelessWidget {
  LedControlWidget({super.key});
  final wsController = Get.find<WebSocketController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => wsController.sendMessage("LED_ON"),
          child: const Text("💡 Encender LED"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => wsController.sendMessage("LED_OFF"),
          child: const Text("🌑 Apagar LED"),
        ),
      ],
    );
  }
}
