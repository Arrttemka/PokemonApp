import 'package:flutter/material.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';

class AppHeader extends StatelessWidget {
  const AppHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PokeApp',
          style: AppFonts.w700s48.copyWith(color: AppColors.white),
        ),
        const SizedBox(width: 10),
        Image.asset(AppImages.logo, width: 64),
      ],
    );
  }
}