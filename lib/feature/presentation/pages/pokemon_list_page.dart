import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_bloc.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_event.dart';
import 'package:pokemon_app/feature/presentation/bloc/pokemon_state.dart';

class PokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Viewer')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoaded) {
              return Text('Pokemon: ${state.pokemon.name}');
            } else if (state is PokemonError) {
              return Text(state.message);
            }
            return ElevatedButton(
              onPressed: () {
                BlocProvider.of<PokemonBloc>(context).add(GetPokemonDetails(1));
              },
              child: Text('Load Pokemon'),
            );
          },
        ),
      ),
    );
  }
}