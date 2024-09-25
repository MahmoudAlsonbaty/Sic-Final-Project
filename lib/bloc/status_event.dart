part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}

final class StatusDataChanged extends StatusEvent {
  final double? windSpeed;
  final bool? headLights;
  final int? temperature;
  final int? mq;
  final double? rainData;
  final double? airQuality;
  final int? Humidity;
  final double? uv;

  StatusDataChanged(
      {this.windSpeed,
      this.headLights,
      this.temperature,
      this.mq,
      this.rainData,
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
