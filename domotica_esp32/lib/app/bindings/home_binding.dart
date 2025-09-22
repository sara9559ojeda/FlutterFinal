// lib/app/bindings/home_binding.dart
import 'package:get/get.dart';
import '../controllers/websocket_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebSocketController());
  }
}
