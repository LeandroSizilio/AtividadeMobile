import 'package:flutter/material.dart';
import '../data/models/ficha.dart';
import '../data/ficha_repository.dart';

class TelaVisualizarFicha extends StatefulWidget {
  final Ficha ficha;

  const TelaVisualizarFicha({Key? key, required this.ficha}) : super(key: key);

  @override
  _TelaVisualizarFicha createState() => _TelaVisualizarFicha();
}

class _TelaVisualizarFicha extends State<TelaVisualizarFicha> {
  final FichaRepository _repository = FichaRepository();
  late int _hp;
  late int _mana;

  @override
  void initState() {
    super.initState();
    _hp = widget.ficha.hp ?? 0;
    _mana = widget.ficha.mana ?? 0;
  }

  void _updateHp(int value) {
    setState(() {
      _hp += value;
      if (_hp < 0) _hp = 0; // Impede HP negativo
    });
  }

  void _updateMana(int value) {
    setState(() {
      _mana += value;
      if (_mana < 0) _mana = 0; // Impede Mana negativa
    });
  }

  Future<void> _salvarAlteracoes() async {
    final fichaAtualizada = Ficha(
      id: widget.ficha.id,
      nome: widget.ficha.nome,
      race: widget.ficha.race,
      str: widget.ficha.str,
      dex: widget.ficha.dex,
      con: widget.ficha.con,
      inteli: widget.ficha.inteli,
      wis: widget.ficha.wis,
      cha: widget.ficha.cha,
      hp: _hp,
      mana: _mana,
    );

    await _repository.update(fichaAtualizada);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ficha atualizada com sucesso!')),
    );

    Navigator.of(context).pop(); // Volta para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha de ${widget.ficha.nome}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Informações não editáveis
            Text('Nome: ${widget.ficha.nome}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Raça: ${widget.ficha.race}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Atributos base
            Text('Atributos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildAttributeRow('Força (STR)', widget.ficha.str ?? 0),
            _buildAttributeRow('Destreza (DEX)', widget.ficha.dex ?? 0),
            _buildAttributeRow('Constituição (CON)', widget.ficha.con ?? 0),
            _buildAttributeRow('Inteligência (INT)', widget.ficha.inteli ?? 0),
            _buildAttributeRow('Sabedoria (WIS)', widget.ficha.wis ?? 0),
            _buildAttributeRow('Carisma (CHA)', widget.ficha.cha ?? 0),
            SizedBox(height: 20),
            // HP e Mana editáveis
            _buildEditableStatRow('HP', _hp, _updateHp),
            _buildEditableStatRow('Mana', _mana, _updateMana),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarAlteracoes,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value.toString(), style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
  
  Widget _buildEditableStatRow(String label, int value, Function(int) onUpdate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => onUpdate(-1),
              ),
              Text(value.toString(), style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onUpdate(1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
