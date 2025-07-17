import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl {
  final http.Client client;
  final String baseUrl = 'http://10.0.2.2:3000/api';

  UserRemoteDataSourceImpl({required this.client});

  Future<Map<String, dynamic>> atualizarPerfilUsuario({String? nome, String? email, String? senha, required String token}) async {
    final Map<String, dynamic> requestBody = {};
    if (nome != null && nome.trim().isNotEmpty) requestBody['nome'] = nome.trim();
    if (email != null && email.trim().isNotEmpty) requestBody['email'] = email.trim().toLowerCase();
    if (senha != null && senha.trim().isNotEmpty) requestBody['senha'] = senha;
    if (requestBody.isEmpty) {
      throw Exception('É necessário informar pelo menos nome, email ou senha para atualizar.');
    }
    final response = await client.put(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao atualizar perfil: ${response.body}');
    }
  }
}
