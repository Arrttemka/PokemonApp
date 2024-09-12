class PokemonsModel {
  int? count;
  String? next;
  Null? previous;
  List<Results>? results;

  PokemonsModel({this.count, this.next, this.previous, this.results});

  PokemonsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
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
}

class Results {
  int? id;
  String? name;
  String? url;
  int? height;
  int? weight;
  List<String>? types;

  Results(
      {this.id,
        this.name,
        this.url,
        this.height,
        this.weight,
        this.types});

  Results.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    url = json['url'];
    weight = json['weight'];
    height = json['height'];
    id = int.parse(url!.split('/')[6]);
    types = json['types'] != null
        ? List<String>.from(json['types'].map((type) => type['type']['name']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['types'] = this.types;
    return data;
  }

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}
