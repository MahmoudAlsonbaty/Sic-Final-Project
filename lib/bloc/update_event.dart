part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

final class UpdateRefreshEvent extends UpdateEvent {}
