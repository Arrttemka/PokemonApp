import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/core/dio_settings/dio_settings.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';
import 'package:pokemon_app/core/database/database_helper.dart';
import 'package:pokemon_app/features/dashboard/dashboard_screen.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = await DatabaseHelper.instance;
  final dioSettings = DioSettings();
  print('Dio baseUrl: ${dioSettings.dio.options.baseUrl}');

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dioSettings),
        RepositoryProvider(
          create: (context) => GetPokemonRepo(
            dio: dioSettings.dio,
            dbHelper: dbHelper,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              repo: context.read<GetPokemonRepo>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

void main() {
  initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        primaryTextTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).primaryTextTheme).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}