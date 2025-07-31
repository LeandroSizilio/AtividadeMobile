class Ficha{
  final int? id;

  final int? str; final int? dex; final int? con; 
  final int? inteli; final int? wis; 

  final int? hp; final int? mana; 
  
  final String nome;
  final String race;
  
  // init
  Ficha({
    this.id, this.str, this.dex, this.con, this.inteli, this.wis,
    this.hp, this.mana, 
    required this.nome, required this.race
    });

  // Convertendo para Map (para salvar no banco)
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'str': str, 'dex': dex, 'con': con, 'inteli': inteli, 'wis': wis,
      'hp': hp, 'mana': mana,
      'nome': nome, 'race': race,
    };
  }

  // Convertendo do Map (quando busca no banco)
  factory Ficha.fromMap(Map<String, dynamic> map){
    return Ficha(
      nome: map['nome'], race: map['race'],
      str: map['str'], dex: map['dex'], con: map['con'], inteli: map['inteli'], wis: map['wis'], 
      hp: map['hp'], mana: map['mana'],
    );
  }
 
}