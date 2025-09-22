// lib/app/models/sensor_model.dart
class SensorModel {
  double temperature;
  bool ledStatus;

  SensorModel({this.temperature = 0, this.ledStatus = false});

  factory SensorModel.fromJson(dynamic json) {
    // Si tu WS envía JSON, parsea aquí
    return SensorModel(
      temperature: json['temperature'] ?? 0,
      ledStatus: json['led'] ?? false,
    );
  }
}
