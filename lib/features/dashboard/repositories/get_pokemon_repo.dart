import 'package:dio/dio.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';

class GetPokemonRepo {
  final Dio dio;

  GetPokemonRepo({required this.dio});

  Future<PokemonsModel> getPokemons(String? name) async {
    final response = await dio.get(
      'pokemon/',
      queryParameters: {
        'name': name,
        'limit': '-1',
      },
    );

    PokemonsModel model = PokemonsModel.fromJson(response.data);
    return model;
  }

  Future<void> getPokemonDetails(Results pokemon) async {
    if (pokemon.height == null || pokemon.weight == null) {
      final detailResponse = await dio.get(pokemon.url!);
      pokemon.updateFromDetailedJson(detailResponse.data);
    }
  }
}