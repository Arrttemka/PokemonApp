import 'package:flutter/material.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.onChaged,
    super.key,
  });


  final Function(String) onChaged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
      color: AppColors.grey,
      ),
        height: 31,
        width: 254,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: TextField(
            style: AppFonts.w500s12
                  .copyWith(color: AppColors.darkGreen),
            onChanged: onChaged,
            decoration: InputDecoration(
              hintStyle: AppFonts.w500s12
                  .copyWith(color: AppColors.darkGreen),
              hintText: 'Search here...',
              fillColor: AppColors.grey,
              filled: true,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ));
  }
}

