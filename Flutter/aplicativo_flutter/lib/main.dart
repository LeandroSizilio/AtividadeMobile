import 'package:flutter/material.dart';
import 'telas/tela_inicial.dart';
import 'telas/tela_menu.dart';
import 'telas/tela_classe.dart';

void main() => runApp(MeuApp());

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/menu': (context) => TelaMenu(),
        '/classe': (context) => TelaClasse(),
      },
    );
  }
}
