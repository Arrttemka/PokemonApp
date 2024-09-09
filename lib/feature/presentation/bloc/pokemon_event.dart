import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPokemonDetails extends PokemonEvent {
  final int id;

  GetPokemonDetails(this.id);

  @override
  List<Object> get props => [id];
}

class GetPokemonList extends PokemonEvent {
  final int page;

  GetPokemonList(this.page);

  @override
  List<Object> get props => [page];
}