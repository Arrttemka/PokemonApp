import 'package:flutter/material.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.model});

  final Results model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('PokeApp',
                      style: AppFonts.w700s48.copyWith(color: AppColors.white)),
                  const SizedBox(
                    width: 7,
                  ),
                  Image.asset(
                    AppImages.logo,
                    width: 64,
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                '${model.name}',
                style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
              ),
              const SizedBox(
                height: 22,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '${model.types}',
                style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
              ),
              Text(
                '${model.weight}',
                style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
              ),
              Text(
                '${model.height}',
                style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
              ),
              Image.asset(
                AppImages.big,
                width: 400,
                height: 400,
                fit: BoxFit.cover
              )
            ],
          ),
        ),
      ),
    );
  }
}
