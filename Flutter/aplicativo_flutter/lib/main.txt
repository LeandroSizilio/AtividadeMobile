import 'package:flutter/material.dart';
import 'data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.verificarBanco();
  runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Banco verificado. Veja o terminal.')))));
}
