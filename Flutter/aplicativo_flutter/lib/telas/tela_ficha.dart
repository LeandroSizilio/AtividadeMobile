import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/models/ficha.dart';
import '../data/database_helper.dart';

class TelaFicha extends StatefulWidget {
  @override
  _TelaFichaState createState() => _TelaFichaState();
}

class _TelaFichaState extends State<TelaFicha> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  // Lista de raças obtidas da API
  List<Map<String, dynamic>> _races = [];
  bool _isLoadingRaces = true;

  // Lista de classes obtidas da API
  List<Map<String, dynamic>> _classes = [];
  bool _isLoadingClasses = true;

  String _selectedRace = 'Escolha a Raça';
  String _selectedClass = 'Escolha a Classe';
  int _pointsAvailable = 10;
  
  // Atributos base
  int _str = 0;
  int _dex = 0;
  int _con = 0;
  int _inteli = 0;
  int _wis = 0;
  int _cha = 0;

  // Atributos com bônus
  int _finalStr = 0;
  int _finalDex = 0;
  int _finalCon = 0;
  int _finalInteli = 0;
  int _finalWis = 0;
  int _finalCha = 0;

  int _hp = 0;
  int _mana = 0;

  // Mapa de bônus da raça
  Map<String, int> _raceBonuses = {
    'str': 0, 'dex': 0, 'con': 0, 'int': 0, 'wis': 0, 'cha': 0
  };
  
  // Variáveis temporárias para a seleção da raça e classe
  String _tempSelectedRace = 'Escolha a Raça';
  String _tempSelectedClass = 'Escolha a Classe';

  @override
  void initState() {
    super.initState();
    _fetchRaces();
    _fetchClasses();
    _calculateStats();
  }

  // Método para buscar as raças da API
  Future<void> _fetchRaces() async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/races');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _races = List<Map<String, dynamic>>.from(data['results']);
          _isLoadingRaces = false;
        });
      } else {
        print('Falha ao carregar raças: ${response.statusCode}');
        setState(() {
          _isLoadingRaces = false;
        });
      }
    } catch (e) {
      print('Erro ao buscar raças: $e');
      setState(() {
        _isLoadingRaces = false;
      });
    }
  }

  // Novo método para buscar as classes da API
  Future<void> _fetchClasses() async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/classes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _classes = List<Map<String, dynamic>>.from(data['results']);
          _isLoadingClasses = false;
        });
      } else {
        print('Falha ao carregar classes: ${response.statusCode}');
        setState(() {
          _isLoadingClasses = false;
        });
      }
    } catch (e) {
      print('Erro ao buscar classes: $e');
      setState(() {
        _isLoadingClasses = false;
      });
    }
  }

  // Método para buscar os bônus de uma raça específica
  Future<void> _fetchRaceBonuses(String raceIndex) async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/races/$raceIndex');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _raceBonuses = {
          'str': 0, 'dex': 0, 'con': 0, 'int': 0, 'wis': 0, 'cha': 0
        };
        for (var bonus in data['ability_bonuses']) {
          String ability = bonus['ability_score']['index'];
          int value = bonus['bonus'];
          if (ability == 'int') { // A API usa 'int' para Intelligence
             ability = 'inteli';
          }
          if (_raceBonuses.containsKey(ability)) {
            _raceBonuses[ability] = value;
          }
        }
        _applyBonuses();
      } else {
        print('Falha ao carregar bônus da raça: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar bônus da raça: $e');
    }
  }

  // Método para buscar detalhes da classe para HP e Mana
  Future<void> _fetchClassDetails(String classIndex) async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/classes/$classIndex');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // A API D&D 5e usa "hit_die" para HP
          _hp = data['hit_die'] ?? 0;
          // A API não tem uma propriedade 'mana' direta, então vamos manter a lógica fixa para mana.
          _mana = _getClassMana(classIndex);
        });
      } else {
        print('Falha ao carregar detalhes da classe: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar detalhes da classe: $e');
    }
  }
  
  // Helper para obter Mana da classe (exemplo)
  int _getClassMana(String classIndex) {
    // Lógica fixa para mana, pois a API não a fornece diretamente
    switch (classIndex) {
      case 'barbarian': return 10;
      case 'bard': return 30;
      case 'cleric': return 40;
      case 'druid': return 35;
      case 'fighter': return 15;
      case 'monk': return 25;
      case 'paladin': return 20;
      case 'ranger': return 18;
      case 'rogue': return 12;
      case 'sorcerer': return 50;
      case 'warlock': return 45;
      case 'wizard': return 60;
      default: return 0;
    }
  }

  // Método para aplicar os bônus de raça aos atributos
  void _applyBonuses() {
    setState(() {
      _finalStr = _str + _raceBonuses['str']!;
      _finalDex = _dex + _raceBonuses['dex']!;
      _finalCon = _con + _raceBonuses['con']!;
      _finalInteli = _inteli + _raceBonuses['int']!;
      _finalWis = _wis + _raceBonuses['wis']!;
      _finalCha = _cha + _raceBonuses['cha']!;
    });
  }

  void _calculateStats() {
    setState(() {
      // HP e Mana agora serão calculados com base na classe selecionada
      if (_selectedClass != 'Escolha a Classe') {
        _fetchClassDetails(_selectedClass.toLowerCase());
      } else {
        _hp = 0;
        _mana = 0;
      }
    });
  }
  
  void _updatePoints(String attribute, int value) {
    setState(() {
      if (value > 0 && _pointsAvailable > 0) {
        _pointsAvailable--;
        switch (attribute) {
          case 'str':
            _str++;
            break;
          case 'dex':
            _dex++;
            break;
          case 'con':
            _con++;
            break;
          case 'inteli':
            _inteli++;
            break;
          case 'wis':
            _wis++;
            break;
          case 'cha':
            _cha++;
            break;
        }
      } else if (value < 0 && _pointsAvailable < 10) {
        switch (attribute) {
          case 'str':
            if (_str > 0) {
              _str--;
              _pointsAvailable++;
            }
            break;
          case 'dex':
            if (_dex > 0) {
              _dex--;
              _pointsAvailable++;
            }
            break;
          case 'con':
            if (_con > 0) {
              _con--;
              _pointsAvailable++;
            }
            break;
          case 'inteli':
            if (_inteli > 0) {
              _inteli--;
              _pointsAvailable++;
            }
            break;
          case 'wis':
            if (_wis > 0) {
              _wis--;
              _pointsAvailable++;
            }
          case 'cha':
            if (_cha > 0) {
              _cha--;
              _pointsAvailable++;
            }
            break;
        }
      }
      _applyBonuses();
    });
  }

  void _showRaceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha uma Raça'),
          content: _isLoadingRaces
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: ListBody(
                    children: _races.map((race) {
                      return ListTile(
                        title: Text(race['name']),
                        onTap: () {
                          setState(() {
                            _tempSelectedRace = race['name'];
                            _fetchRaceBonuses(race['index']);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  _selectedRace = _tempSelectedRace;
                  _calculateStats();
                });
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

  void _showClassSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha uma Classe'),
          content: _isLoadingClasses
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: ListBody(
                    children: _classes.map((dndClass) {
                      return ListTile(
                        title: Text(dndClass['name']),
                        onTap: () {
                          setState(() {
                            _tempSelectedClass = dndClass['name'];
                            _fetchClassDetails(dndClass['index']); // Fetch class details
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  _selectedClass = _tempSelectedClass;
                  _calculateStats();
                });
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Nova Ficha'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Personagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do personagem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _showRaceSelection(context),
                    child: Text(_selectedRace),
                  ),
                  ElevatedButton(
                    onPressed: () => _showClassSelection(context),
                    child: Text(_selectedClass),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Pontos Disponíveis: $_pointsAvailable', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildAttributeRow('Força (STR)', 'str', _str, _finalStr),
              _buildAttributeRow('Destreza (DEX)', 'dex', _dex, _finalDex),
              _buildAttributeRow('Constituição (CON)', 'con', _con, _finalCon),
              _buildAttributeRow('Inteligência (INT)', 'inteli', _inteli, _finalInteli),
              _buildAttributeRow('Sabedoria (WIS)', 'wis', _wis, _finalWis),
              _buildAttributeRow('Carisma (CHA)', 'cha', _cha, _finalCha),
              SizedBox(height: 20),
              Text('HP: $_hp', style: TextStyle(fontSize: 18)),
              Text('Mana: $_mana', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedRace == 'Escolha a Raça' || _selectedClass == 'Escolha a Classe') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor, escolha uma raça e uma classe.')),
                      );
                      return;
                    }

                    if (_pointsAvailable > 0) {
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor, distribua todos os 10 pontos.')),
                      );
                      return;
                    }

                    final ficha = Ficha(
                      nome: _nomeController.text,
                      race: _selectedRace,
                      str: _finalStr,
                      dex: _finalDex,
                      con: _finalCon,
                      inteli: _finalInteli,
                      wis: _finalWis,
                      cha: _finalCha,
                      hp: _hp,
                      mana: _mana,
                    );
                    
                    final dbHelper = DatabaseHelper.instance;
                    final db = await dbHelper.database;
                    await db.insert('fichas', ficha.toMap());
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ficha de RPG salva com sucesso!')),
                    );
                    Navigator.of(context).pop(); // Volta para a tela anterior
                  }
                },
                child: Text('Salvar Ficha'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Novo método para construir a linha de atributos com bônus
  Widget _buildAttributeRow(String label, String attribute, int baseValue, int finalValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => _updatePoints(attribute, -1),
              ),
              Text(
                '$baseValue', 
                style: TextStyle(fontSize: 18)
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _updatePoints(attribute, 1),
              ),
              SizedBox(width: 10),
              Text(
                'Total: $finalValue', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
