part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final PokemonsModel model;

  DashboardSuccess({required this.model});
}

final class DashboardError extends DashboardState {
  final String message;

  DashboardError({required this.message});
}

final class DashboardEmpty extends DashboardState {}