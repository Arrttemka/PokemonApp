import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/core/dio_settings/dio_settings.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';

import 'features/dashboard/dashboard_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GetPokemonRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => DashboardBloc(repo: RepositoryProvider.of<GetPokemonRepo>(context),
        ),
        child: MaterialApp(
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            home: const DashboardScreen()),
      ),
    ); // MaterialApp
  }
}
