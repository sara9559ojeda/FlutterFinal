import '../repositories/websocket_repository.dart';

class DisconnectWebSocket {
  final WebSocketRepository repository;

  DisconnectWebSocket(this.repository);

  void call() {
    repository.disconnect();
  }
}
