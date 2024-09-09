import 'package:hive/hive.dart';
import 'package:pokemon_app/feature/core/error/exceptions.dart';
import 'package:pokemon_app/feature/data/models/pokemon_model.dart';

abstract class PokemonLocalDataSource {
  Future<void> cachePokemon(PokemonModel pokemon);
  Future<PokemonModel> getCachedPokemon(int id);
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final HiveInterface hive;

  PokemonLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cachePokemon(PokemonModel pokemon) async {
    var box = await hive.openBox('pokemonBox');
    box.put(pokemon.name, pokemon.toJson());
    await box.close();
  }

  @override
  Future<PokemonModel> getCachedPokemon(int id) async {
    var box = await hive.openBox('pokemonBox');
    final pokemon = box.get(id);
    await box.close();
    if (pokemon != null) {
      return PokemonModel.fromJson(pokemon);
    } else {
      throw CacheException();
    }
  }
}