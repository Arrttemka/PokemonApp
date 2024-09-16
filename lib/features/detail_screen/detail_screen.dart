import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/app_header.dart';
import 'package:pokemon_app/core/widgets/pokemon_type_view.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/detail_screen/cubit/detail_cubit.dart';
import 'package:pokemon_app/features/dashboard/repositories/get_pokemon_repo.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.model}) : super(key: key);

  final Results model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(
        repo: context.read<GetPokemonRepo>(),
        initialPokemon: model,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailError) {
              return _buildErrorView(context, state.message);
            } else if (state is DetailLoaded) {
              return _buildPokemonDetails(context, state.pokemon);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error loading details',
            style: AppFonts.w600s24.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppFonts.w500s18.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<DetailCubit>().loadPokemonDetails();
            },
            child: Text('Retry', style: AppFonts.w500s18),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonDetails(BuildContext context, Results pokemon) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppHeader(),
                const SizedBox(height: 40),
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      pokemon.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.lightGrey,
                          child: Icon(Icons.error, size: 50, color: AppColors.white),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  pokemon.name ?? '',
                  style: AppFonts.w600s24.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: pokemon.types?.map(pokemonTypeView).toList() ?? [],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Weight: ${pokemon.weight}',
                        style: AppFonts.w500s18.copyWith(color: AppColors.white)),
                    Text('Height: ${pokemon.height}',
                        style: AppFonts.w500s18.copyWith(color: AppColors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}