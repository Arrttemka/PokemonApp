import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/feature/domain/entities/pokemon.dart';
import 'package:pokemon_app/feature/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_event.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemonDetails getPokemonDetails;
  final GetPokemonList getPokemonList;

  PokemonBloc({
    required this.getPokemonDetails,
    required this.getPokemonList,
  }) : super(PokemonEmpty()) {
    on<GetPokemonDetails>(
          (event, emit) async {
        emit(PokemonLoading());
        final failureOrPokemon = await getPokemonDetails(Params(id: event.id));
        failureOrPokemon.fold(
              (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
              (pokemon) => emit(PokemonLoaded(pokemon: pokemon)),
        );
      },
    );

    on<GetPokemonList>(
          (event, emit) async {
        emit(PokemonLoading());
        final failureOrPokemonList = await getPokemonList(Params(page: event.page));
        failureOrPokemonList.fold(
              (failure) => emit(PokemonError(message: _mapFailureToMessage(failure))),
              (pokemonList) => emit(PokemonListLoaded(pokemonList: pokemonList)),
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Handle different types of failures
  }
}