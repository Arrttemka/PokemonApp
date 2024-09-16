class Results {
  int? id;
  String? name;
  String? url;
  int? height;
  int? weight;
  List<String>? types;

  Results({
    this.id,
    this.name,
    this.url,
    this.height,
    this.weight,
    this.types,
  });

  Results.fromJson(Map<String, dynamic> json) {
    name = capitalizeFirstLetter(json['name']);
    url = json['url'];
    weight = json['weight'];
    height = json['height'];
    id = json['id'] ?? (url != null ? int.parse(url!.split('/')[6]) : null);
    types = json['types'] is String
        ? (json['types'] as String).split(',')
        : (json['types'] as List<dynamic>?)?.map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'weight': weight,
      'height': height,
      'types': types?.join(','), // Сохраняем типы как строку, разделенную запятыми
    };
  }

  void updateFromDetailedJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    types = json['types'] != null
        ? List<String>.from(json['types'].map((type) => type['type']['name']))
        : null;
  }


  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}


class PokemonsModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  PokemonsModel({this.count, this.next, this.previous, this.results});

  PokemonsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Добавьте метод копирования
  PokemonsModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<Results>? results,
  }) {
    return PokemonsModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}