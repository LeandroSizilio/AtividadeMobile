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
  final List<String> savingThrows; // Testes de Resistência
  final List<String> proficiencies; // Proficiências com armas, armaduras, etc.
  final List<String> proficiencyChoices; // Descrição das escolhas de perícia
  final List<String> startingEquipment; // Equipamentos iniciais
  final List<String> startingEquipmentOptions; // Opções de equipamento
  final List<String> subclasses; // Subclasses disponíveis
  final String spellcastingAbility; // Habilidade de conjuração (se houver)

  ClasseDetalhes({
    required this.name, 
    required this.hitDie,
  required this.savingThrows,
    required this.proficiencies,
    required this.proficiencyChoices,
    required this.startingEquipment,
    required this.startingEquipmentOptions,
    required this.subclasses,
    required this.spellcastingAbility,
    
    });

  factory ClasseDetalhes.fromJson(Map<String, dynamic> json) {
    // Função auxiliar para converter uma lista de objetos JSON em uma List<String>
    List<String> _mapJsonListToStringList(List<dynamic> list, String key) {
      return list.map((item) => item[key] as String).toList();
    }
    
    // Função para formatar o equipamento inicial
    List<String> _formatEquipment(List<dynamic> list) {
      return list.map((item) {
        return "${item['equipment']['name']} (x${item['quantity']})";
      }).toList();
    }
    return ClasseDetalhes(
      name: json['name'],
      hitDie: json['hit_die'],
      savingThrows: _mapJsonListToStringList(json['saving_throws'], 'name'),
      proficiencies: _mapJsonListToStringList(json['proficiencies'], 'name'),
      proficiencyChoices: _mapJsonListToStringList(json['proficiency_choices'], 'desc'),
      startingEquipment: _formatEquipment(json['starting_equipment']),
      startingEquipmentOptions: _mapJsonListToStringList(json['starting_equipment_options'], 'desc'),
      subclasses: _mapJsonListToStringList(json['subclasses'], 'name'),
      spellcastingAbility: json['spellcasting'] != null 
          ? json['spellcasting']['spellcasting_ability']['name'] 
          : 'Nenhuma',
    );
  }
}