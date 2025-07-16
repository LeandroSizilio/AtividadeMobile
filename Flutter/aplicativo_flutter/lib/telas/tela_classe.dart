import 'package:flutter/material.dart';

class TelaClasse extends StatelessWidget {
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
          // Toolbar superior
          Positioned(
            top: 36,
            left: 20,
            right: 20,
            child: Container(
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
                  SizedBox(width: 10),
                  Image.asset('assets/imagens/classes.png', height: 65),
                ],
              ),
            ),
          ),
          // Texto no meio da tela
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Text(
              'Clique na classe e saiba mais sobre',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Botões das classes (simplificado)
          Positioned(
            bottom: 160,
            left: 20,
            child: Column(
              children: [
                Image.asset('assets/imagens/mago.png', height: 140),
                Text('Mago', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Positioned(
            bottom: 160,
            left: 150,
            child: Column(
              children: [
                Image.asset('assets/imagens/r.png', height: 140),
                Text('Ladino', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Positioned(
            bottom: 160,
            right: 20,
            child: Column(
              children: [
                Image.asset('assets/imagens/clerigo.png', height: 140),
                Text('Clérigo', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Botão voltar
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Voltar'),
            ),
          )
        ],
      ),
    );
  }
}
