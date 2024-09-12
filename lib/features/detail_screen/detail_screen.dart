import 'package:flutter/material.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
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
                'Pokemon list',
                style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                'Find the pokemon you want',
                style: AppFonts.w500s14.copyWith(color: AppColors.lightGrey),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
