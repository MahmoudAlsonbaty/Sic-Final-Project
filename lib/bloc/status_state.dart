part of 'status_bloc.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}

final class StatusUpdate extends StatusState {
  final double windSpeed;
  final bool headLights;
  final int temperature;
  final int mq;
  final double rainData;
  final double airQuality;
  final int Humidity;
  final double uv;

  StatusUpdate(
      {required this.windSpeed,
      required this.headLights,
      required this.temperature,
      required this.mq,
      required this.rainData,
      required this.airQuality,
      required this.Humidity,
      required this.uv});
}
