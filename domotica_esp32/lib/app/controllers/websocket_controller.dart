// lib/app/controllers/websocket_controller.dart
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/sensor_model.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel _channel;
  var status = "🟡 Conectando...".obs;
  var sensorData = SensorModel().obs;

  @override
  void onInit() {
    super.onInit();
    _connect();
  }

  void _connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.9:8085'),
    );

    _channel.stream.listen(
      (message) {
        // Aquí parseas a tu modelo de sensor
        sensorData.value = SensorModel.fromJson(message);
        status.value = "📥 Recibido: $message";
      },
      onDone: () => status.value = "🔴 Desconectado",
      onError: (error) => status.value = "⚠️ Error de conexión",
    );

    status.value = "🟢 Conectado";
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
    status.value = "📤 Enviado: $message";
  }

  @override
  void onClose() {
    _channel.sink.close();
    super.onClose();
  }
}
