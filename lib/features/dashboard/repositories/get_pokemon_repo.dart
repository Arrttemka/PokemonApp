import 'package:dio/dio.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/dashboard/models/results_model.dart';
import 'package:pokemon_app/core/database/database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GetPokemonRepo {
  final Dio dio;
  final DatabaseHelper dbHelper;

  GetPokemonRepo({required this.dio, required this.dbHelper});

  Future<bool> hasInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<PokemonsModel> getPokemons(String? name) async {
    bool isOnline = await hasInternetConnection();
    bool isFirstLaunch = await dbHelper.isFirstLaunch();
    bool hasLocalData = await dbHelper.hasLocalData();

    print('Is online: $isOnline, Is first launch: $isFirstLaunch, Has local data: $hasLocalData');

    if (isOnline) {
      try {
        final model = await _fetchAllPokemons();

        if (isFirstLaunch) {
          await _saveInitialPokemonsLocally();
          await dbHelper.setFirstLaunch(false);
        }

        return model;
      } catch (e) {
        if (hasLocalData) {
          final localPokemons = await dbHelper.getAllPokemons();
          return PokemonsModel(results: localPokemons);
        }
        throw Exception('Failed to load pokemons: $e');
      }
    } else {
      if (hasLocalData) {
        final localPokemons = await dbHelper.getAllPokemons();
        return PokemonsModel(results: localPokemons);
      } else {
        throw Exception('No internet connection and no local data available');
      }
    }
  }

  Future<void> _saveInitialPokemonsLocally() async {
    final response = await dio.get(
      'pokemon',
      queryParameters: {
        'limit': '20',
        'offset': '0',
      },
    );
    PokemonsModel initialPokemons = PokemonsModel.fromJson(response.data);
    for (var pokemon in initialPokemons.results ?? []) {
      await dbHelper.insertPokemon(pokemon);
    }
    print('Saved ${initialPokemons.results?.length ?? 0} pokemons locally');
  }

  Future<PokemonsModel> _fetchAllPokemons() async {
    final response = await dio.get(
      'pokemon',
      queryParameters: {
        'limit': '-1',
        'offset': '0',
      },
    );
    return PokemonsModel.fromJson(response.data);
  }



  Future<void> getPokemonDetails(Results pokemon) async {
    try {
      if (pokemon.height == null || pokemon.weight == null) {
        final detailResponse = await dio.get(pokemon.url!);
        pokemon.updateFromDetailedJson(detailResponse.data);

        pokemon.types = (detailResponse.data['types'] as List<dynamic>)
            .map((type) => type['type']['name'] as String)
            .toList();

        await dbHelper.insertPokemon(pokemon);
      }
    } catch (e) {
      final cachedPokemon = await dbHelper.getPokemon(pokemon.id!);
      if (cachedPokemon != null) {
        pokemon.updateFromDetailedJson(cachedPokemon.toJson());
      } else {
        throw Exception('Failed to load Pokemon details: $e');
      }
    }
  }
}