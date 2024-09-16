import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/app_header.dart';
import 'package:pokemon_app/core/widgets/pokemon_type_view.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.model});

  final Results model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder(
        future: _loadPokemonDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildPokemonDetails();
          }
        },
      ),
    );
  }

  Future<void> _loadPokemonDetails(BuildContext context) async {
    final dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    await dashboardBloc.repo.getPokemonDetails(model);
  }

  Widget _buildPokemonDetails() {
    return SingleChildScrollView(
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
                  model.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              model.name ?? '',
              style: AppFonts.w600s24.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: model.types?.map(pokemonTypeView).toList() ?? [],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Weight: ${model.weight}',
                    style: AppFonts.w500s18.copyWith(color: AppColors.white)),
                Text('Height: ${model.height}',
                    style: AppFonts.w500s18.copyWith(color: AppColors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}