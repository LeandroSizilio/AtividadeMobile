import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adicionamos o GestureDetector envolvendo todo o conteúdo
    return GestureDetector(
      onTap: () {
        // Ação de navegar para a tela de menu
        Navigator.pushNamed(context, '/menu');
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Fundo
            Positioned.fill(
              child: Image.asset(
                'assets/imagens/image5.png',
                fit: BoxFit.cover,
              ),
            ),
            // Dobradicas
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/imagens/dobradica1.png'),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/imagens/dobradica2.png'),
            ),
            // Logo e nome
            Positioned(
              top: 100,
              left: 50,
              right: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/imagens/dado20.png', height: 100),
                  SizedBox(width: 10),
                  Image.asset('assets/imagens/logo.png', height: 80),
                ],
              ),
            ),
            // Fechadura
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/imagens/fechadura2.png', height: 820),
            ),
            // Canto inferior
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/imagens/canto_inferior_direito2.png'),
            ),
            // Créditos
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Desenvolvido por Leandro e Felipe',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}