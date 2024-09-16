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
      'types': types?.join(','),
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