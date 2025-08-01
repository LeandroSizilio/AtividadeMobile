import 'package:flutter/material.dart';

class TelaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo
          Positioned.fill(
            child: Image.asset(
              'assets/imagens/folha3.png',
              fit: BoxFit.cover,
            ),
          ),
          // Escudo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                'assets/imagens/escudo.png',
                height: 157,
                width: 121,
              ),
            ),
          ),
          // Dragão sobre o escudo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Image.asset(
                  'assets/imagens/dragao.png',
                  height: 109,
                  width: 77,
                ),
              ),
            ),
          ),
          // Botão de Classes
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/classe');
                },
                child: Container(
                  width: 150,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black, // Cor #000000
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset('assets/imagens/classes.png'),
                  ),
                ),
              ),
            ),
          ),
          // Botão de Fichas (Atualizado para navegar)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/fichas'); // Rota corrigida para a tela de lista
                },
                child: Container(
                  width: 150,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.black, // Cor #000000
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('assets/imagens/fichas.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
