// tela_classe.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Ajuste o caminho
import '../data/models/classe_model.dart'; // Ajuste o caminho
import 'tela_detalhes_classe.dart'; // Tela que criaremos a seguir

class TelaClasse extends StatefulWidget {
  @override
  _TelaClasseState createState() => _TelaClasseState();
}

class _TelaClasseState extends State<TelaClasse> {
  final ApiService _apiService = ApiService();
  late Future<List<ClasseResumo>> _classesFuture;

  @override
  void initState() {
    super.initState();
    _classesFuture = _apiService.fetchClasses();
  }
  
  // Função para mapear o 'index' da API para suas imagens locais
  String _getImagemDaClasse(String classIndex) {
    // A API usa nomes em inglês (wizard, rogue, cleric).
    // Associe-os às suas imagens.
    final Map<String, String> mapaImagens = {
      'barbarian': 'assets/imagens/barbaro.png', // Exemplo, adicione as suas
      'bard': 'assets/imagens/bardo.png',       // Exemplo
      'cleric': 'assets/imagens/clerigo.png',
      'druid': 'assets/imagens/druida.png',     // Exemplo
      'fighter': 'assets/imagens/guerreiro.png', // Exemplo
      'monk': 'assets/imagens/monge.png',       // Exemplo
      'paladin': 'assets/imagens/paladino.png', // Exemplo
      'ranger': 'assets/imagens/ranger.png',    // Exemplo
      'rogue': 'assets/imagens/ladino.png', // Seu 'r.png' provavelmente é o rogue
      'sorcerer': 'assets/imagens/feiticeiro.png', // Exemplo
      'warlock': 'assets/imagens/bruxo.png',    // Exemplo
      'wizard': 'assets/imagens/mago.png',
    };
    
    // Retorna a imagem correspondente ou uma imagem padrão
    return mapaImagens[classIndex] ?? 'assets/imagens/logo_dice.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo
          Positioned.fill(
            child: Image.asset(
              'assets/imagens/folha2.png',
              fit: BoxFit.cover,
            ),
          ),
          // Conteúdo principal
          SafeArea(
            child: Column(
              children: [
                // Toolbar superior (mantida como no seu layout)
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    border: Border.all(
                      color: const Color(0xFF333333),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/imagens/logo_dice.png', height: 95),
                      const SizedBox(width: 10),
                      Image.asset('assets/imagens/classes.png', height: 65),
                    ],
                  ),
                ),
                const Text(
                  'Clique na classe para saber mais',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Grid dinâmica de classes
                Expanded(
                  child: FutureBuilder<List<ClasseResumo>>(
                    future: _classesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final classes = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 colunas
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            final classe = classes[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaDetalhesClasse(
                                      classIndex: classe.index,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          _getImagemDaClasse(classe.index),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        classe.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('Nenhuma classe encontrada.'));
                      }
                    },
                  ),
                ),
                // Botão voltar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}