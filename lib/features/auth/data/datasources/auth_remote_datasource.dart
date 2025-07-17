import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<Map<String, dynamic>> obterPerfil(String token);
  Future<Map<String, dynamic>> logout();
  Future<Map<String, dynamic>> refreshToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  final String baseUrl = "http://10.0.2.2:3000/api";

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> obterPerfil(String token) async {
    print("DEBUG - Obtendo perfil com token: $token");

    final response = await client.get(
      Uri.parse("$baseUrl/auth/profile"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("DEBUG - Status Code: ${response.statusCode}");
    print("DEBUG - Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Falha ao obter perfil: ${response.body}");
    }
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    print("DEBUG - Enviando login para: $baseUrl/login");
    print("DEBUG - Email: $email");
    print("DEBUG - Password: $password");

    final response = await client.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({"email": email, "senha": password}),
    );

    print("DEBUG - Status Code: ${response.statusCode}");
    print("DEBUG - Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Falha no login: ${response.body}");
    }
  }



  @override
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final response = await client.post(
      Uri.parse("$baseUrl/usuarios"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({
        "nome": name,
        "email": email,
        "senha": password,
        "confirmarSenha": confirmPassword,
        "permissao": "estoquista",
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception("Falha no registro: ${response.body}");
    }
  }

  @override
  Future<Map<String, dynamic>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String token) {
    throw UnimplementedError();
  }
}
