import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/feature/core/error/exceptions.dart';
import 'package:pokemon_app/feature/data/models/pokemon_model.dart';
import 'package:pokemon_app/feature/core/utils/constants.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon(int id);
  Future<List<PokemonModel>> getPokemonList(int page);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonModel> getPokemon(int id) async {
    final response = await client.get(
      Uri.parse('${APIConstants.baseURL}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PokemonModel>> getPokemonList(int page) async {
    final response = await client.get(
      Uri.parse('${APIConstants.baseURL}?limit=20&offset=${page * 20}'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return (data['results'] as List).map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
    } else {
      throw ServerException();
    }
  }
}