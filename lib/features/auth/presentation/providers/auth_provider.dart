import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  // Para facilitar testes, considere injetar estas dependências no construtor.
  // Veja a seção de melhorias abaixo.
  final AuthRemoteDataSourceImpl _authDataSource = AuthRemoteDataSourceImpl(client: http.Client());
  final UserRemoteDataSourceImpl _userDataSource = UserRemoteDataSourceImpl(client: http.Client());

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  /// Realiza o login do usuário e armazena os dados localmente.
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      final result = await _authDataSource.login(email, password);
      // Aceita múltiplos formatos do backend
      final data = result['data'] ?? result;
      // Se vier aninhado, pega o objeto correto
      final userData = (data['usuario'] is Map && data['usuario']['usuario'] != null)
          ? data['usuario']['usuario']
          : data['usuario'] ?? result['usuario'] ?? data['user'] ?? data;
      final token = data['token'] ?? result['token'] ?? (data['usuario']?['token']) ?? '';

      if (token.isEmpty) {
        throw Exception("Token não recebido do servidor.");
      }

      // Garante que o id será corretamente mapeado, seja de MongoDB (_id) ou id.
      String id = userData['_id'] ?? userData['id'] ?? '';
      if (id.isEmpty) {
         throw Exception("ID do usuário não encontrado na resposta do servidor. O backend deve retornar o campo _id ou id no login.");
      }
      
      _user = User(
        id: id,
        nome: userData['nome'] ?? '',
        email: userData['email'] ?? '',
        codigoFuncionario: userData['codigoFuncionario'],
        permissao: userData['permissao'] ?? '',
        token: token,
      );

      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Registra um novo usuário.
  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    _setLoading(true);
    _setError(null);
    try {
      // O método register da sua fonte de dados pode retornar dados úteis.
      // Considere usar o `result` para, por exemplo, logar o usuário automaticamente.
      await _authDataSource.register(name, email, password, confirmPassword);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Atualiza o perfil do usuário logado.
  Future<bool> updateProfile({required String nome, required String email, String? senha}) async {
    _setLoading(true);
    _setError(null);
    try {
      if (_user == null || _user!.token.isEmpty) {
        throw Exception('Usuário não autenticado.');
      }

      final usuarioId = _user!.id;
      if (usuarioId.isEmpty) {
        throw Exception('ID do usuário está vazio. Não é possível atualizar perfil.');
      }

      debugPrint('Atualizando perfil para usuarioId: $usuarioId');

      // Chama a fonte de dados para atualizar o perfil usando a rota correta (PUT /api/usuario/perfil)
      await _userDataSource.atualizarPerfilUsuario(
        nome: nome,
        email: email,
        senha: senha,
        token: _user!.token,
      );

      // Atualiza o estado local do usuário com os novos dados
      _user = _user?.copyWith(nome: nome, email: email);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Realiza o logout do usuário.
  Future<void> logout() async {
    _user = null;
    _error = null;
    notifyListeners();
    // Aqui você também pode limpar o token de SharedPreferences ou Secure Storage, se estiver usando.
  }
}