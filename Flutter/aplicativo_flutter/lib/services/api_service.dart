// services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/classe_model.dart'; 

class ApiService {
  final String _baseUrl = 'https://www.dnd5eapi.co/api';

  // Busca a lista de todas as classes
  Future<List<ClasseResumo>> fetchClasses() async {
    final response = await http.get(Uri.parse('$_baseUrl/classes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => ClasseResumo.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as classes');
    }
  }

  // Busca os detalhes de uma classe específica pelo seu 'index'
  Future<ClasseDetalhes> fetchClasseDetails(String classIndex) async {
    final response = await http.get(Uri.parse('$_baseUrl/classes/$classIndex'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ClasseDetalhes.fromJson(data);
    } else {
      throw Exception('Falha ao carregar detalhes da classe');
    }
  }
}