import 'dart:convert';

class ClasseResumo {
  final String index;
  final String name;
  final String url;

  ClasseResumo({required this.index, required this.name, required this.url});

  factory ClasseResumo.fromJson(Map<String, dynamic> json) {
    return ClasseResumo(
      index: json['index'],
      name: json['name'],
      url: json['url'],
    );
  }
}

class ClasseDetalhes {
  final String name;
  final int hitDie;

  ClasseDetalhes({required this.name, required this.hitDie});

  factory ClasseDetalhes.fromJson(Map<String, dynamic> json) {
    return ClasseDetalhes(
      name: json['name'],
      hitDie: json['hit_die'],
      // proficiencies: json['proficiencies'],
    );
  }
}