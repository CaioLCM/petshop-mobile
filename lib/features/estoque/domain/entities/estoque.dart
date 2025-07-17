class Estoque {
  final String id;
  final String produtoId;
  String produtoNome;
  String produtoMarca;
  String produtoTipo;
  final String lote;
  final int quantidade;
  final DateTime dataValidade;
  final DateTime dataCadastro;
  final DateTime? dataUltimaEdicao;

  Estoque({
    required this.id,
    required this.produtoId,
    required this.produtoNome,
    this.produtoMarca = '',
    this.produtoTipo = '',
    required this.lote,
    required this.quantidade,
    required this.dataValidade,
    required this.dataCadastro,
    this.dataUltimaEdicao,
  });

  factory Estoque.fromJson(Map<String, dynamic> json) {
    String produtoId = '';
    String produtoNome = 'Produto sem nome';
    String produtoMarca = '';
    String produtoTipo = '';
    final produtoField = json['produto'];
    if (produtoField is Map) {
      produtoId = produtoField['_id']?.toString() ?? produtoField['id']?.toString() ?? '';
      produtoNome = produtoField['nome'] ?? 'Produto sem nome';
      produtoMarca = produtoField['marca'] ?? '';
      produtoTipo = produtoField['tipo'] ?? '';
    } else {
      produtoId = produtoField?.toString() ?? '';
      produtoNome = json['produtoNome'] ?? 'Produto sem nome';
      produtoMarca = json['produtoMarca'] ?? '';
      produtoTipo = json['produtoTipo'] ?? '';
    }
    return Estoque(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      produtoId: produtoId,
      produtoNome: produtoNome,
      produtoMarca: produtoMarca,
      produtoTipo: produtoTipo,
      lote: json['lote'] ?? '',
      quantidade: json['quantidade'] ?? 0,
      dataValidade: json['data_validade'] != null
          ? DateTime.parse(json['data_validade'])
          : DateTime.now(),
      dataCadastro: json['data_cadastro'] != null
          ? DateTime.parse(json['data_cadastro'])
          : DateTime.now(),
      dataUltimaEdicao: json['data_ultima_edicao'] != null
          ? DateTime.parse(json['data_ultima_edicao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produto': produtoId,
      'produtoNome': produtoNome,
      'produtoMarca': produtoMarca,
      'produtoTipo': produtoTipo,
      'lote': lote,
      'quantidade': quantidade,
      'data_validade': dataValidade.toIso8601String(),
      'data_cadastro': dataCadastro.toIso8601String(),
      'data_ultima_edicao': dataUltimaEdicao?.toIso8601String(),
    };
  }
}