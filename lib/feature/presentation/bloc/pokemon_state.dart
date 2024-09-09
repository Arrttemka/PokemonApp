import 'package:equatable/equatable.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonEmpty extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final Pokemon pokemon;

  PokemonLoaded({required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError({required this.message});

  @override
  List<Object> get props => [message];
}

class PokemonListLoaded extends PokemonState {
  final List<Pokemon> pokemonList;

  PokemonListLoaded({required this.pokemonList});

  @override
  List<Object> get props => [pokemonList];
}