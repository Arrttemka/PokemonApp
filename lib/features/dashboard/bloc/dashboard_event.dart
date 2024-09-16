part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetPokemonEvent extends DashboardEvent {
  final String? name;
  GetPokemonEvent({this.name});
}

class GetPokemonDetailsEvent extends DashboardEvent {
  final Results pokemon;
  GetPokemonDetailsEvent(this.pokemon);
}