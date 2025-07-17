import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ProdutoRemoteDatasource {
  Future<Map<String, dynamic>> cadastrarProduto(
    String nome,
    String tipo,
    String marca,
    double preco,
    int quantidade,
    String descricao,
    String token,
  );
  Future<Map<String, dynamic>> editarProduto(
    String id,
    String nome,
    String tipo,
    String marca,
    double preco,
    int quantidade,
    String descricao,
    String token,
  );
  Future<List<Map<String, dynamic>>> listarProdutos();
}

class ProdutoRemoteDataSourceImpl implements ProdutoRemoteDatasource {
  final http.Client client;
  final String baseUrl = 'http://10.0.2.2:3000/api';

  ProdutoRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> cadastrarProduto(
    String nome,
    String tipo,
    String marca,
    double preco,
    int quantidade,
    String descricao,
    String token,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'nome': nome,
        'tipo': tipo,
        'marca': marca,
        'preco': preco,
        'quantidade': quantidade,
        'dataCadastro': DateTime.now().toIso8601String(),
        'descricao': descricao,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha no cadastro: ${response.body}');
    }
  }

  @override
Future<Map<String, dynamic>> editarProduto(
  String id,
  String nome,
  String tipo,
  String marca,
  double preco,
  int quantidade,
  String descricao,
  String token,
) async {
  if (id.isEmpty) {
    throw Exception('ID do produto não pode estar vazio');
  }

  final response = await client.put(
    Uri.parse('$baseUrl/produtos/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'nome': nome,
      'tipo': tipo,
      'marca': marca,
      'preco': preco,
      'quantidade': quantidade,
      'descricao': descricao,
    }),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falha na edição: ${response.body}');
  }
}

  @override
  Future<List<Map<String, dynamic>>> listarProdutos() async {
    final response = await client.get(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha ao listar produtos: ${response.body}');
    }
  }
}