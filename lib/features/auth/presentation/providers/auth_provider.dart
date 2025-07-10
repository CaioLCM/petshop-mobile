import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/user.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  late final AuthRemoteDataSourceImpl _authDataSource;

  AuthProvider() {
    _authDataSource = AuthRemoteDataSourceImpl(client: http.Client());
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _authDataSource.login(email, password);
      
      final data = result['data'] ?? result;
      final userData = data['usuario'] ?? data['user'] ?? data;
      final token = data['token'] ?? '';

      if (token.isEmpty) {
        throw Exception("Token não recebido do servidor");
      }

      _user = User(
        id: userData['_id'] ?? userData['id'] ?? '',
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

  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    try {
      _setLoading(true);
      _setError(null);

      final result = await _authDataSource.register(name, email, password, confirmPassword);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

Future<bool> updateProfile(String nome, String email, String senha) async {
  try {
    _setLoading(true);
    _setError(null);

    final result = await _authDataSource.updateProfile(nome, email, senha);
    
    if (_user != null) {
      _user = User(
        id: _user!.id,
        nome: nome,
        email: email,
        codigoFuncionario: _user!.codigoFuncionario,
        permissao: _user!.permissao,
        token: _user!.token,
      );
      notifyListeners();
    }
    
    return true;
  } catch (e) {
    _setError(e.toString());
    return false;
  } finally {
    _setLoading(false);
  }
}

  void logout() {
    _user = null;
    _error = null;
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