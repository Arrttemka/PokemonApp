import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/poke_card.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:pokemon_app/features/dashboard/models/pokemon_model.dart';
import 'package:pokemon_app/features/detail_screen/detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardBloc>().add(GetPokemonEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 22),
              _buildTitle(),
              const SizedBox(height: 22),
              _buildSubtitle(),
              const SizedBox(height: 20),
              Expanded(
                child: _buildPokemonList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PokeApp',
          style: AppFonts.w700s48.copyWith(color: Colors.black),
        ),
        const SizedBox(width: 7),
        Image.asset(
          AppImages.logo,
          width: 64,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Pokemon list',
      style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Find the pokemon you want',
      style: AppFonts.w500s14.copyWith(color: AppColors.lightGrey),
    );
  }



  Widget _buildPokemonList() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardInitial) {
          context.read<DashboardBloc>().add(GetPokemonEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.model.results?.length ?? 0,
            itemBuilder: (context, index) => PokeCard(
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
        } else if (state is DashboardEmpty) {
          return const Center(child: Text('No Pokemons found.'));
        } else if (state is DashboardError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: AppFonts.w500s14.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<DashboardBloc>().add(GetPokemonEvent());
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}