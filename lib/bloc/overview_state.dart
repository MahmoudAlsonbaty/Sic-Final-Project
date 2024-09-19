part of 'overview_bloc.dart';

@immutable
sealed class OverviewState {}

final class OverviewBatteryStatus extends OverviewState {
  final battery;
  OverviewBatteryStatus({required this.battery});
}
