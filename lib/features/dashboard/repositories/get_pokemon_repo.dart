import 'package:dio/dio.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';

class GetPokemonRepo {
  final Dio dio;

  GetPokemonRepo({
    required this.dio
  });

  Future<PokemonsModel> getPokemons() async {
    final response = await dio.get('pokemon/');

    return PokemonsModel.fromJson(response.data);
  }
}