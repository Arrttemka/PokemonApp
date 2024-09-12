import 'package:flutter/material.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({
    required this.name,
    required this.image,
    required this.onTap,
    super.key,
  });

  final String name;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 124,
        width: 300,
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 74,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 21),
                child: Text(
                  name,
                  style: AppFonts.w500s18
                      .copyWith(color: AppColors.white),
                ),
              ),
            ),
            Positioned(
                top: 24,
                right: 0,
                child: Image.asset(
                  image,
                  width: 120,
                ))
          ],
        ),
      ),
    );
  }
}
