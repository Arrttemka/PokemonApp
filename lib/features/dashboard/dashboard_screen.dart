import 'package:flutter/material.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/custom_text_field.dart';
import 'package:pokemon_app/core/widgets/poke_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                        style:
                            AppFonts.w700s48.copyWith(color: AppColors.white)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(onChaged: (val) {}),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: IconButton(
                          color: AppColors.darkGreen,
                          icon: const Icon(
                            Icons.search,
                              color: AppColors.darkGreen,
                              size: 20,
                              ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => PokeCard(
                      name: "Bulbik", 
                      image: AppImages.bulb, 
                    onTap:() {
                      
                    },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

