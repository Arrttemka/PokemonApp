import 'package:get_it/get_it.dart';
import 'package:pokemon_app/feature/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokemon_app/feature/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app/feature/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_app/feature/domain/usecases/get_pokemon.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(
        () => PokemonBloc(getPokemon: sl()),
  );

  // Usecases
  sl.registerLazySingleton(
        () => GetPokemon(sl()),
  );

  // Repository
  sl.registerLazySingleton<PokemonRepository>(
        () => PokemonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
        () => PokemonRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
}
*/