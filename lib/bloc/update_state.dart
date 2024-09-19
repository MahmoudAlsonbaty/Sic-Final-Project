part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class UpdateRefresh extends UpdateState {
  int random;
  UpdateRefresh({required this.random});
}
