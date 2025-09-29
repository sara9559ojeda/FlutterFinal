import 'package:domotica_esp32/domain/repositories/websocket_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketRepositoryImpl implements WebSocketRepository {
  late WebSocketChannel _channel;

  @override
  void connect({
    required void Function(String message) onMessage,
    void Function()? onDone,
    void Function(Object error)? onError,
  }) {
    final url = dotenv.env['WS_URL']!;
    _channel = WebSocketChannel.connect(Uri.parse(url));

    // 👇 Identificación del cliente Flutter
    _channel.sink.add("CLIENT:FLUTTER_APP");

    _channel.stream.listen(
      (event) => onMessage(event.toString()),
      onDone: onDone,
      onError: onError,
    );
  }

  @override
  void send(String message) {
    _channel.sink.add(message);
  }

  @override
  void disconnect() {
    _channel.sink.close();
  }
}
