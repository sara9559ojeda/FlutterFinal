import '../repositories/websocket_repository.dart';

class SendMessage {
  final WebSocketRepository repository;

  SendMessage(this.repository);

  void call(String message) {
    repository.send(message);
  }
}
