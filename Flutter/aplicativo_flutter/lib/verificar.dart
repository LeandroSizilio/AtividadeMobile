import 'package:flutter/widgets.dart';
import 'data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário por conta do path_provider
  await DatabaseHelper.instance.verificarBanco();
}
