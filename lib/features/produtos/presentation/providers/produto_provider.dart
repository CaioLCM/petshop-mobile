import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/produto.dart';
import '../../data/datasources/produto_remote_datasource.dart';

class ProdutoProvider with ChangeNotifier {
  List<Produto> _produtos = [];
  bool _isLoading = false;
  String? _error;

  late final ProdutoRemoteDataSourceImpl _produtoDataSource;

  ProdutoProvider() {
    _produtoDataSource = ProdutoRemoteDataSourceImpl(client: http.Client());
  }

  List<Produto> get produtos => _produtos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> cadastrarProduto(
    String nome,
    String tipo,
    String marca,
    double preco,  // ADICIONAR
    int quantidade,
    String descricao,
    String token,
  ) async {
    try {
      _setLoading(true);
      _setError(null);

      await _produtoDataSource.cadastrarProduto(
        nome,
        tipo,
        marca,
        preco,  // ADICIONAR
        quantidade,
        descricao,
        token,
      );

      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> editarProduto(
    String id,
    String nome,
    String tipo,
    String marca,
    double preco,  // ADICIONAR
    int quantidade,
    String descricao,
    String token,
  ) async {
    try {
      _setLoading(true);
      _setError(null);

      await _produtoDataSource.editarProduto(
        id,
        nome,
        tipo,
        marca,
        preco,  // ADICIONAR
        quantidade,
        descricao,
        token,
      );

      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> listarProdutos() async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _produtoDataSource.listarProdutos();
      _produtos = result.map((json) => Produto.fromJson(json)).toList();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}