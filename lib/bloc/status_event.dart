part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}

final class StatusDataChanged extends StatusEvent {
  final int? windSpeed;
  final bool? headLights;
  final int? temperature;
  final int? batteryTemperature;
  final double? fanSpeed;
  final int? airQuality;
  final int? Humidity;
  final int? uv;

  StatusDataChanged(
      {this.windSpeed,
      this.headLights,
      this.temperature,
      this.batteryTemperature,
      this.fanSpeed,
      this.airQuality,
      this.Humidity,
      this.uv});
}

final class StatusUpdateFirebaseEvent extends StatusEvent {
  final bool? headLights;
  final double? fanSpeed;

  StatusUpdateFirebaseEvent({
    this.headLights,
    this.fanSpeed,
  });
}
