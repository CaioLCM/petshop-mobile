
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:petshop_mobile/features/produtos/domain/entities/produto.dart';
import '../../domain/entities/estoque.dart';
import '../../data/datasources/estoque_remote_datasource.dart';


class EstoqueProvider with ChangeNotifier {
  Future<bool> editarEstoque(
    String id,
    String produtoId,
    String lote,
    int quantidade,
    DateTime dataValidade,
    String token,
  ) async {
    try {
      _setLoading(true);
      _setError(null);
      await _estoqueDataSource.editarEstoque(
        id,
        produtoId,
        lote,
        quantidade,
        dataValidade,
        token,
      );
      await listarEstoque(token);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  List<Estoque> _estoques = [];
  bool _isLoading = false;
  String? _error;
  late final EstoqueRemoteDataSourceImpl _estoqueDataSource;

  EstoqueProvider() {
    _estoqueDataSource = EstoqueRemoteDataSourceImpl(client: http.Client());
  }

  List<Estoque> get estoques => _estoques;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> registrarBaixa(
    String estoqueId,
    int quantidade,
    String motivo,
    String token,
    {String? observacoes, String? itemEstoque}
  ) async {
    try {
      _setLoading(true);
      _setError(null);
      // Buscar o produtoId do estoque selecionado
      final estoque = _estoques.firstWhere(
        (e) => e.id == estoqueId,
        orElse: () => throw Exception('Estoque não encontrado'),
      );
      await _estoqueDataSource.registrarBaixa(
        estoque.produtoId,
        quantidade,
        motivo,
        token,
        observacoes: observacoes,
        itemEstoque: itemEstoque,
      );
      await listarEstoque(token);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> cadastrarEstoque(
    String produtoId,
    String lote,
    int quantidade,
    DateTime dataValidade,
    String token,
  ) async {
    try {
      _setLoading(true);
      _setError(null);

      await _estoqueDataSource.cadastrarEstoque(
        produtoId,
        lote,
        quantidade,
        dataValidade,
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

  Future<void> listarEstoque(String token, {List<Produto>? produtos}) async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _estoqueDataSource.listarEstoque(token);
      _estoques = result.map((json) => Estoque.fromJson(json)).toList();
      if (produtos != null) {
        preencherNomeProduto(produtos);
      }
      print(_estoques);
      print("Quantidade de estoques carregados: \\${_estoques.length}");
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void preencherNomeProduto(List<Produto> produtos) {
    for (var estoque in _estoques) {
      final produto = produtos.firstWhere(
        (p) => p.id == estoque.produtoId,
        orElse: () => Produto(
          id: '',
          nome: 'Produto sem nome',
          tipo: '',
          marca: '',
          preco: 0,
          quantidade: 0,
          dataCadastro: DateTime.now(),
          descricao: '',
        ),
      );
      estoque.produtoNome = produto.nome;
      estoque.produtoMarca = produto.marca;
      estoque.produtoTipo = produto.tipo;
    }
    notifyListeners();
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