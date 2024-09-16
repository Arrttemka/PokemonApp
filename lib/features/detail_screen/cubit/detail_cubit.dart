import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';


abstract class DetailState {}

class DetailInitial extends DetailState {}
class DetailLoading extends DetailState {}
class DetailLoaded extends DetailState {
  final Results pokemon;
  DetailLoaded(this.pokemon);
}
class DetailError extends DetailState {
  final String message;
  DetailError(this.message);
}


class DetailCubit extends Cubit<DetailState> {
  final GetPokemonRepo repo;
  final Results initialPokemon;

  DetailCubit({required this.repo, required this.initialPokemon}) : super(DetailInitial()) {
    loadPokemonDetails();
  }

  Future<void> loadPokemonDetails() async {
    emit(DetailLoading());
    try {
      await repo.getPokemonDetails(initialPokemon);
      emit(DetailLoaded(initialPokemon));
    } catch (e) {
      emit(DetailError('Failed to load Pokemon details: $e'));
    }
  }
}