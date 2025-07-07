import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AuthRemoteDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String name, String email, String password);
  Future<Map<String, dynamic>> logout();
  Future<Map<String, dynamic>> refreshToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  final String baseUrl = "";

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> login (String email, String password) async {
    final response = await client.post(Uri.parse("$baseUrl/login"),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    body: json.encode({
      "email": email,
      "password": password
    })
    );

    if (response.statusCode == 200){
      return json.decode(response.body);
    } else {
      throw Exception("Falha no login: ${response.body}");
    }
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password) async{
    final response = await http.post(Uri.parse("$baseUrl/auth/register"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    body: json.encode({
      "name": name,
      "email": email,
      "password": password
    })
    );

    if (response.statusCode == 200){
      return json.decode(response.body);
    }
    else {
      throw Exception("Falha no registro: ${response.body}");
    }
  }

  @override
  Future<Map<String, dynamic>> logout(){
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String token){
    throw UnimplementedError();
  }
}