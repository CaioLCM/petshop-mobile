
import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class EstoqueRemoteDatasource {
  Future<Map<String, dynamic>> cadastrarEstoque(
    String produtoId,
    String lote,
    int quantidade,
    DateTime dataValidade,
    String token,
  );
  Future<List<Map<String, dynamic>>> listarEstoque(String token);
}

class EstoqueRemoteDataSourceImpl implements EstoqueRemoteDatasource {
  final http.Client client;
  final String baseUrl = 'http://10.0.2.2:3000/api';

  EstoqueRemoteDataSourceImpl({required this.client});

  Future<Map<String, dynamic>> registrarBaixa(
    String produtoId,
    int quantidade,
    String motivo,
    String token,
    {String? observacoes, String? itemEstoque}
  ) async {
    final motivosValidos = [
      'venda', 'perda', 'vencimento', 'transferencia', 'ajuste', 'outro'
    ];
    if (!motivosValidos.contains(motivo)) {
      throw Exception('Motivo inválido. Use: venda, perda, vencimento, transferencia, ajuste ou outro');
    }
    final requestBody = {
      'produtoId': produtoId,
      'quantidade': quantidade,
      'motivo': motivo,
    };
    if (observacoes != null && observacoes.trim().isNotEmpty) {
      requestBody['observacoes'] = observacoes.trim();
    }
    if (itemEstoque != null && itemEstoque.trim().isNotEmpty) {
      requestBody['item_estoque'] = itemEstoque.trim();
    }
    final response = await client.post(
      Uri.parse('$baseUrl/estoque/baixa'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao registrar baixa: ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> cadastrarEstoque(
    String produtoId,
    String lote,
    int quantidade,
    DateTime dataValidade,
    String token,
  ) async {
    final requestBody = {
      'produto': produtoId,
      'lote': lote,
      'quantidade': quantidade,
      'data_validade': dataValidade.toIso8601String(),
      'data_cadastro': DateTime.now().toIso8601String(),
      'usuario_editou': 'mobile_app',
    };

    final response = await client.post(
      Uri.parse('$baseUrl/estoque'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha no cadastro de estoque: ${response.body}');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> listarEstoque(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/estoque'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Falha ao listar estoque: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editarEstoque(
    String id,
    String produtoId,
    String lote,
    int quantidade,
    DateTime dataValidade,
    String token,
  ) async {
    final requestBody = {
      'produto': produtoId,
      'lote': lote,
      'quantidade': quantidade,
      'data_validade': dataValidade.toIso8601String(),
      'usuario_editou': 'mobile_app',
    };
    final response = await client.put(
      Uri.parse('$baseUrl/estoque/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao editar estoque: \\${response.body}');
    }
  }
}
