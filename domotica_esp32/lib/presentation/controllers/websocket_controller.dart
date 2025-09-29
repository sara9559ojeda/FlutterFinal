import 'package:get/get.dart';
import '../../domain/usecases/connect_websocket.dart';
import '../../domain/usecases/send_message.dart'; 
import '../../domain/usecases/disconnect_websocket.dart';

class WebSocketController extends GetxController {
  final ConnectWebSocket connectWebSocket;
  final SendMessage sendMessageUseCase;
  final DisconnectWebSocket disconnectWebSocket;

  WebSocketController({
    required this.connectWebSocket,
    required this.sendMessageUseCase,
    required this.disconnectWebSocket,
  });

  final status = "🟡 Conectando...".obs;

  @override
  void onInit() {
    super.onInit();
    connectWebSocket(
      onMessage: (msg) => status.value = "📥 Recibido: $msg",
      onDone: () => status.value = "🔴 Desconectado",
      onError: (_) => status.value = "⚠️ Error de conexión",
    );
    status.value = "🟢 Conectado";
  }

  void sendMessage(String msg) {
    sendMessageUseCase(msg);
    status.value = "📤 Enviado: $msg";
  }

  @override
  void onClose() {
    disconnectWebSocket();
    super.onClose();
  }
}
