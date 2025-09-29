import '../repositories/websocket_repository.dart';

class ConnectWebSocket {
  final WebSocketRepository repository;

  ConnectWebSocket(this.repository);

  void call({
    required void Function(String) onMessage,
    required void Function() onDone,
    required void Function(Object) onError,
  }) {
    repository.connect(
      onMessage: onMessage,
      onDone: onDone,
      onError: onError,
    );
  }
}
