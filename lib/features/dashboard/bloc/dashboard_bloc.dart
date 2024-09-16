import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.repo}) : super(DashboardInitial()) {
    on<GetPokemonEvent>((event, emit) async {
      emit(DashboardLoading());
      try {
        final model = await repo.getPokemons(event.name);
        emit(DashboardSuccess(model: model));
      } catch (e) {
        emit(DashboardError());
      }
    });

    on<GetPokemonDetailsEvent>((event, emit) async {
      try {
        await repo.getPokemonDetails(event.pokemon);
        emit(DashboardSuccess(model: (state as DashboardSuccess).model));
      } catch (e) {
        emit(DashboardError());
      }
    });
  }
  final GetPokemonRepo repo;
}