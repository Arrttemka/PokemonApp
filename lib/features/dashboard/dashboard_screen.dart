import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/core/assets/app_images.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_fonts.dart';
import 'package:pokemon_app/core/widgets/poke_card.dart';
import 'package:pokemon_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:pokemon_app/features/dashboard/models/results_model.dart';
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
            children: const [
              HeaderWidget(),
              SizedBox(height: 22),
              TitleWidget(),
              SizedBox(height: 22),
              SubtitleWidget(),
              SizedBox(height: 20),
              Expanded(
                child: PokemonListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PokeApp',
          style: AppFonts.w700s48.copyWith(color: Colors.white),
        ),
        const SizedBox(width: 7),
        Image.asset(
          AppImages.logo,
          width: 64,
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Pokemon list',
      style: AppFonts.w600s24.copyWith(color: AppColors.lightGrey),
    );
  }
}

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Find the pokemon you want',
      style: AppFonts.w500s14.copyWith(color: AppColors.lightGrey),
    );
  }
}

class PokemonListWidget extends StatelessWidget {
  const PokemonListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardInitial) {
          context.read<DashboardBloc>().add(GetPokemonEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardSuccess) {
          return PokemonListViewWidget(state: state);
        } else if (state is DashboardEmpty) {
          return const Center(child: Text('No Pokemons found.'));
        } else if (state is DashboardError) {
          return ErrorWidget(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class PokemonListViewWidget extends StatelessWidget {
  final DashboardSuccess state;

  const PokemonListViewWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;

  const ErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
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
}