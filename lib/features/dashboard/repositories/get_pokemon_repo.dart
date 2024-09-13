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
        'limit': '20',
      },
    );

    PokemonsModel model = PokemonsModel.fromJson(response.data);

    // Fetch detailed information for each Pokemon
    for (var result in model.results!) {
      final detailResponse = await dio.get(result.url!);
      result.updateFromDetailedJson(detailResponse.data);
    }

    return model;
  }
}
