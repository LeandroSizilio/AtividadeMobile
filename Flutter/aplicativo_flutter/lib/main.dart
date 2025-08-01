import 'package:flutter/material.dart';
import 'telas/tela_inicial.dart';
import 'telas/tela_menu.dart';
import 'telas/tela_classe.dart';
import 'telas/tela_ficha.dart'; // Importe a nova tela de ficha
import 'telas/telas_listar_fichas.dart'; // Importe a nova tela de ficha

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/menu': (context) => TelaMenu(),
        '/classe': (context) => TelaClasse(),
        '/ficha': (context) => TelaFicha(), // Adicione a nova rota
        '/fichas': (context) => TelaListaFichas(), // Adicione a nova rota
      },
    );
  }
}
