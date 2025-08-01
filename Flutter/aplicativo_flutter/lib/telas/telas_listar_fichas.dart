import 'package:flutter/material.dart';
import '../data/ficha_repository.dart';
import '../data/models/ficha.dart';
import 'tela_visualizar_ficha.dart';

class TelaListaFichas extends StatefulWidget {
  @override
  _TelaListaFichasState createState() => _TelaListaFichasState();
}

class _TelaListaFichasState extends State<TelaListaFichas> {
  final FichaRepository _repository = FichaRepository();
  List<Ficha> _fichas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarFichas();
  }

  Future<void> _carregarFichas() async {
    setState(() {
      _isLoading = true;
    });
    final fichas = await _repository.getAllFichas();
    setState(() {
      _fichas = fichas;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Fichas de RPG'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/ficha');
                      _carregarFichas(); // Recarrega a lista ao voltar da tela de criação
                    },
                    child: Text('Criar Ficha'),
                  ),
                ),
                Expanded(
                  child: _fichas.isEmpty
                      ? Center(
                          child: Text(
                            'Sem fichas criadas',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _fichas.length,
                          itemBuilder: (context, index) {
                            final ficha = _fichas[index];
                            return ListTile(
                              title: Text(ficha.nome),
                              subtitle: Text(ficha.race),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await _repository.delete(ficha.id!);
                                  _carregarFichas(); // Recarrega a lista após deletar
                                },
                              ),
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaVisualizarFicha(ficha: ficha),
                                  ),
                                );
                                _carregarFichas(); // Recarrega a lista após voltar da tela de visualização
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}