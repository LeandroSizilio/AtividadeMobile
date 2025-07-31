import 'package:flutter/material.dart';
import '../data/models/ficha.dart';
import '../data/database_helper.dart';

class TelaFicha extends StatefulWidget {
  @override
  _TelaFichaState createState() => _TelaFichaState();
}

class _TelaFichaState extends State<TelaFicha> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  String _selectedRace = 'Escolha a Raça';
  String _selectedClass = 'Escolha a Classe';
  int _pointsAvailable = 10;
  
  int _str = 0;
  int _dex = 0;
  int _con = 0;
  int _inteli = 0;
  int _wis = 0;

  int _hp = 0;
  int _mana = 0;

  final Map<String, int> baseHpByRace = {
    'Humano': 50,
    'Elfo': 40,
    'Anão': 60,
  };

  final Map<String, int> baseManaByClass = {
    'Guerreiro': 10,
    'Mago': 50,
    'Arqueiro': 20,
  };

  @override
  void initState() {
    super.initState();
    _calculateStats();
  }

  void _calculateStats() {
    setState(() {
      _hp = (_selectedRace != 'Escolha a Raça') ? baseHpByRace[_selectedRace]! : 0;
      _mana = (_selectedClass != 'Escolha a Classe') ? baseManaByClass[_selectedClass]! : 0;
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
            break;
        }
      }
    });
  }

  void _showRaceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha uma Raça'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text('Humano'),
                  onTap: () {
                    setState(() {
                      _selectedRace = 'Humano';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Elfo'),
                  onTap: () {
                    setState(() {
                      _selectedRace = 'Elfo';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Anão'),
                  onTap: () {
                    setState(() {
                      _selectedRace = 'Anão';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text('Guerreiro'),
                  onTap: () {
                    setState(() {
                      _selectedClass = 'Guerreiro';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Mago'),
                  onTap: () {
                    setState(() {
                      _selectedClass = 'Mago';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Arqueiro'),
                  onTap: () {
                    setState(() {
                      _selectedClass = 'Arqueiro';
                      _calculateStats();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
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
              _buildAttributeRow('Força (STR)', 'str', _str),
              _buildAttributeRow('Destreza (DEX)', 'dex', _dex),
              _buildAttributeRow('Constituição (CON)', 'con', _con),
              _buildAttributeRow('Inteligência (INT)', 'inteli', _inteli),
              _buildAttributeRow('Sabedoria (WIS)', 'wis', _wis),
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
                      str: _str,
                      dex: _dex,
                      con: _con,
                      inteli: _inteli,
                      wis: _wis,
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

  Widget _buildAttributeRow(String label, String attribute, int value) {
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
              Text(value.toString(), style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _updatePoints(attribute, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
