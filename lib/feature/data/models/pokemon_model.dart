import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final String name;
  final String imageUrl;
  final List<String> types;
  final int weight;
  final int height;

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.weight,
    required this.height,
  });

  @override
  List<Object> get props => [name, imageUrl, types, weight, height];

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: List<String>.from(json['types'].map((type) => type['type']['name'])),
      weight: json['weight'],
      height: json['height'],
    );
  }
}