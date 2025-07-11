class Produto {
  final String id;
  final String nome;
  final String tipo;
  final String marca;
  final double preco;  
  final int quantidade;
  final DateTime dataCadastro;
  final String descricao;

  Produto({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.marca,
    required this.preco,  
    required this.quantidade,
    required this.dataCadastro,
    required this.descricao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['_id']?.toString() ?? json['id'].toString() ?? '',
      nome: json['nome'] ?? '',
      tipo: json['tipo'] ?? '',
      marca: json['marca'] ?? '',
      preco: (json['preco'] ?? 0).toDouble(),  
      quantidade: json['quantidade'] ?? 0,
      dataCadastro: json['dataCadastro'] != null 
          ? DateTime.parse(json['dataCadastro'])
          : DateTime.now(),
      descricao: json['descricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'marca': marca,
      'preco': preco,
      'quantidade': quantidade,
      'dataCadastro': dataCadastro.toIso8601String(),
      'descricao': descricao,
    };
  }
}