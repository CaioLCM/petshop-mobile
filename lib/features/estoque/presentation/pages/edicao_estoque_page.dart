import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../produtos/presentation/providers/produto_provider.dart';
import '../../../produtos/domain/entities/produto.dart';
import '../providers/estoque_provider.dart';
import '../../domain/entities/estoque.dart';

class EdicaoEstoquePage extends StatefulWidget {
  final Estoque estoque;
  const EdicaoEstoquePage({Key? key, required this.estoque}) : super(key: key);

  @override
  State<EdicaoEstoquePage> createState() => _EdicaoEstoquePageState();
}

class _EdicaoEstoquePageState extends State<EdicaoEstoquePage> {
  late TextEditingController loteController;
  late TextEditingController quantidadeController;
  late TextEditingController dataValidadeController;
  Produto? produtoSelecionado;

  @override
  void initState() {
    super.initState();
    loteController = TextEditingController(text: widget.estoque.lote);
    quantidadeController = TextEditingController(
      text: widget.estoque.quantidade.toString(),
    );
    dataValidadeController = TextEditingController(
      text: widget.estoque.dataValidade.toString().split(' ')[0],
    );
    produtoSelecionado = Produto(
      id: widget.estoque.produtoId,
      nome: widget.estoque.produtoNome,
      tipo: '',
      marca: '',
      preco: 0,
      quantidade: 0,
      dataCadastro: DateTime.now(),
      descricao: '',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).listarProdutos();
    });
  }

  Future<void> _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.estoque.dataValidade,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() {
        dataValidadeController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _editarEstoque() async {
    try {
      String lote = loteController.text.trim();
      String quantidadeStr = quantidadeController.text.trim();
      String dataValidadeStr = dataValidadeController.text.trim();
      if (produtoSelecionado == null ||
          lote.isEmpty ||
          quantidadeStr.isEmpty ||
          dataValidadeStr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Todos os campos são obrigatórios!")),
        );
        return;
      }
      int quantidade = int.tryParse(quantidadeStr) ?? 0;
      if (quantidade <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Quantidade deve ser um número válido!")),
        );
        return;
      }
      DateTime dataValidade = DateTime.parse(dataValidadeStr);
      final estoqueProvider = Provider.of<EstoqueProvider>(
        context,
        listen: false,
      );
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user == null || authProvider.user!.token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro: Usuário não autenticado"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final success = await estoqueProvider.editarEstoque(
        widget.estoque.id,
        produtoSelecionado!.id,
        lote,
        quantidade,
        dataValidade,
        authProvider.user!.token,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Estoque editado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro: ${estoqueProvider.error}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProdutoProvider, EstoqueProvider>(
      builder: (context, produtoProvider, estoqueProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF0F9FF),
          body: Center(
            child: Container(
              width: 400,
              constraints: BoxConstraints(minHeight: 420),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF60A5FA), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<Produto>(
                          value:
                              produtoProvider.produtos.any(
                                    (p) => p.id == produtoSelecionado?.id,
                                  )
                                  ? produtoProvider.produtos.firstWhere(
                                    (p) => p.id == produtoSelecionado?.id,
                                  )
                                  : null,
                          decoration: InputDecoration(
                            labelText: "Selecionar Produto",
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF3B82F6),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items:
                              produtoProvider.produtos.map((produto) {
                                return DropdownMenuItem<Produto>(
                                  value: produto,
                                  child: Text(
                                    "${produto.nome} - ${produto.marca}",
                                  ),
                                );
                              }).toList(),
                          onChanged: (Produto? newValue) {
                            setState(() {
                              produtoSelecionado = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: loteController,
                          decoration: InputDecoration(
                            labelText: "Lote",
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF3B82F6),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: quantidadeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Quantidade",
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF3B82F6),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: dataValidadeController,
                          readOnly: true,
                          onTap: _selecionarData,
                          decoration: InputDecoration(
                            labelText: "Data de validade",
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            suffixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF3B82F6),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton(
                      onPressed:
                          estoqueProvider.isLoading ? null : _editarEstoque,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(90, 36),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child:
                          estoqueProvider.isLoading
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                "Editar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF020A22),
                                ),
                              ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Voltar",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    loteController.dispose();
    quantidadeController.dispose();
    dataValidadeController.dispose();
    super.dispose();
  }
}
