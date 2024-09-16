import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/dashboard/models/results_model.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.repo}) : super(DashboardInitial()) {
    on<GetPokemonEvent>((event, emit) async {
      print('GetPokemonEvent triggered');
      emit(DashboardLoading());
      try {
        final model = await repo.getPokemons(event.name);
        if (model.results?.isEmpty ?? true) {
          emit(DashboardEmpty());
        } else {
          emit(DashboardSuccess(model: model.copyWith()));
        }
      } catch (e) {
        if (e.toString().contains('No internet connection and no local data available')) {
          emit(DashboardError(message: 'No internet connection and no local data. Please connect to the internet for first launch.'));
        } else if (e.toString().contains('No internet connection')) {
          emit(DashboardError(message: 'No internet connection. Showing cached data.'));
        } else {
          emit(DashboardError(message: 'Failed to load Pokemons. Error: $e'));
        }
      }
    });

    on<GetPokemonDetailsEvent>((event, emit) async {
      try {
        await repo.getPokemonDetails(event.pokemon);
        emit(DashboardSuccess(model: (state as DashboardSuccess).model));
      } catch (e) {
        emit(DashboardError(message: 'Error when loading...'));
      }
    });
  }
  final GetPokemonRepo repo;
}