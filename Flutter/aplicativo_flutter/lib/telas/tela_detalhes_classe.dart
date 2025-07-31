// tela_detalhes_classe.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Ajuste o caminho
import '../data/models/classe_model.dart'; // Ajuste o caminho

class TelaDetalhesClasse extends StatefulWidget {
  final String classIndex;

  const TelaDetalhesClasse({Key? key, required this.classIndex}) : super(key: key);

  @override
  _TelaDetalhesClasseState createState() => _TelaDetalhesClasseState();
}

class _TelaDetalhesClasseState extends State<TelaDetalhesClasse> {
  final ApiService _apiService = ApiService();
  late Future<ClasseDetalhes> _detalhesFuture;

  @override
  void initState() {
    super.initState();
    _detalhesFuture = _apiService.fetchClasseDetails(widget.classIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Classe'),
        backgroundColor: Colors.brown, // Cor temática de D&D
      ),
      body: FutureBuilder<ClasseDetalhes>(
        future: _detalhesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar detalhes: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final detalhes = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detalhes.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(height: 30, thickness: 2),
                  
                  // Exemplo de como exibir um dado
                  Card(
                    child: ListTile(
                      title: const Text('Dado de Vida (Hit Die)', style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        'd${detalhes.hitDie}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  
                  // Adicione aqui mais widgets para exibir outras informações
                  // Ex: Proficiências, Equipamentos, etc.
                  // Você precisará adicionar esses campos ao seu modelo ClasseDetalhes
                  // e parseá-los do JSON.

                  const SizedBox(height: 20),
                  Text(
                    'Aqui você pode adicionar mais detalhes como proficiências, equipamentos iniciais, habilidades, etc., buscando-os da API e exibindo-os.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Nenhum detalhe encontrado.'));
          }
        },
      ),
    );
  }
}