import 'package:flutter/material.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/app_header.dart';
import 'package:pokemon_app/core/widgets/pokemon_type_view.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.model});

  final Results model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final whiteTextStyle = textTheme.bodyLarge!.copyWith(color: AppColors.white);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                  Text('Weight: ${model.weight}', style: whiteTextStyle),
                  Text('Height: ${model.height}', style: whiteTextStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

