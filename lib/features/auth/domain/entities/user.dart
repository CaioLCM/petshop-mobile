class User {
  final String id;
  final String nome;
  final String email;
  final String? codigoFuncionario;
  final String permissao;
  final String token;

  User({
    required this.id,
    required this.nome,
    required this.email,
    this.codigoFuncionario,
    required this.permissao,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      codigoFuncionario: json['codigo_funcionario'],
      permissao: json['permissao'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'codigo_funcionario': codigoFuncionario,
      'permissao': permissao,
      'token': token,
    };
  }

  User copyWith({
    String? id,
    String? nome,
    String? email,
    String? codigoFuncionario,
    String? permissao,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      codigoFuncionario: codigoFuncionario ?? this.codigoFuncionario,
      permissao: permissao ?? this.permissao,
      token: token ?? this.token,
    );
  }
}
