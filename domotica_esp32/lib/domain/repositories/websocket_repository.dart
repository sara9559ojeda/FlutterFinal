abstract class WebSocketRepository {
  void connect({
    required void Function(String message) onMessage,
    void Function()? onDone,
    void Function(Object error)? onError,
  });

  void send(String message);
  void disconnect();
}
