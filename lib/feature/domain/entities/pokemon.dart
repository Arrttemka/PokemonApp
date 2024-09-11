import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String type;
  final String weight;
  final String height;
  final String image;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.weight,
    required this.height,
    required this.image,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}