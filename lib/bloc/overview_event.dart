part of 'overview_bloc.dart';

@immutable
sealed class OverviewEvent {}

final class OverviewEventDataChanged extends OverviewEvent {
  final int battery;
  OverviewEventDataChanged({required this.battery});
}
