// tela_detalhes_classe.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../data/models/classe_model.dart';

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

  // Widget auxiliar para criar seções de informação de forma consistente
  Widget _buildInfoSection({required String title, required List<String> items, IconData? icon}) {
    if (items.isEmpty) return const SizedBox.shrink(); // Não mostra nada se a lista for vazia

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: Colors.brown, size: 20),
                if (icon != null) const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
              ],
            ),
            const Divider(height: 16),
            // Usa o ... (spread operator) para adicionar todos os widgets da lista
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('• $item', style: const TextStyle(fontSize: 15)),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${widget.classIndex.capitalize()}'),
        backgroundColor: Colors.brown[700],
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
                  // --- SEÇÃO PRINCIPAL ---
                  Card(
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Text('d${detalhes.hitDie}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(detalhes.name, style: Theme.of(context).textTheme.headlineSmall),
                      subtitle: const Text('Dado de Vida'),
                    ),
                  ),
                  if (detalhes.spellcastingAbility != 'Nenhuma')
                  Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(top: 8),
                    child: ListTile(
                       leading: const Icon(Icons.auto_stories, color: Colors.brown),
                       title: const Text('Habilidade de Conjuração'),
                       trailing: Text(detalhes.spellcastingAbility, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- SEÇÕES DE LISTA USANDO O WIDGET AUXILIAR ---
                  
                  _buildInfoSection(
                    title: 'Testes de Resistência',
                    items: detalhes.savingThrows,
                    icon: Icons.shield_outlined,
                  ),

                  _buildInfoSection(
                    title: 'Proficiências',
                    items: detalhes.proficiencies,
                    icon: Icons.star_border,
                  ),

                  _buildInfoSection(
                    title: 'Escolhas de Perícias',
                    items: detalhes.proficiencyChoices,
                    icon: Icons.check_circle_outline,
                  ),

                  _buildInfoSection(
                    title: 'Equipamento Inicial',
                    items: detalhes.startingEquipment,
                    icon: Icons.backpack_outlined,
                  ),

                  _buildInfoSection(
                    title: 'Opções de Equipamento',
                    items: detalhes.startingEquipmentOptions,
                    icon: Icons.ballot_outlined,
                  ),
                  
                  _buildInfoSection(
                    title: 'Subclasses Disponíveis',
                    items: detalhes.subclasses,
                    icon: Icons.groups_2_outlined,
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

// Pequena extensão para deixar a primeira letra maiúscula
extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
}