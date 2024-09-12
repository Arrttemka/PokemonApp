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
      },
    );

    return PokemonsModel.fromJson(response.data);
  }
}
