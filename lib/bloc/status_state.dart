part of 'status_bloc.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}

final class StatusUpdate extends StatusState {
  final int windSpeed;
  final bool headLights;
  final int temperature;
  final int batteryTemperature;
  final double fanSpeed;
  final int airQuality;
  final int Humidity;
  final int uv;

  StatusUpdate(
      {required this.windSpeed,
      required this.headLights,
      required this.temperature,
      required this.batteryTemperature,
      required this.fanSpeed,
      required this.airQuality,
      required this.Humidity,
      required this.uv});
}
