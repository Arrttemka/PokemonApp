import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/custom_text_field.dart';
import 'package:pokemon_app/core/widgets/poke_card.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/detail_screen/detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(GetPokemonEvent());
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
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.model.results?.length,
                          itemBuilder: (context, index) =>
                              PokeCard(
                                name: state.model.results?[index].name ?? '',
                                image: state.model.results?[index].imageUrl ?? '',
                                onTap: () {
                                  final pokemon = state.model.results?[index] ?? Results();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        model: pokemon,
                                      ),
                                    ),
                                  );
                                },
                              ),
                        );
                      }
                      return const Text('not found');
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
