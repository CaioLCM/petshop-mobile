import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import '../providers/estoque_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../produtos/presentation/providers/produto_provider.dart';
import '../../../produtos/domain/entities/produto.dart';

class CadastroEstoquePage extends StatefulWidget {
  const CadastroEstoquePage({super.key});

  @override
  State<CadastroEstoquePage> createState() => _CadastroEstoquePageState();
}

class _CadastroEstoquePageState extends State<CadastroEstoquePage> {
  TextEditingController loteController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController dataValidadeController = TextEditingController();
  
  Produto? produtoSelecionado;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).listarProdutos();
    });
  }

  Future<void> _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() {
        dataValidadeController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _cadastrarEstoque() async {
    print("DEBUG - Produto selecionado ID: '${produtoSelecionado!.id}'");
    print("DEBUG - Produto selecionado nome: '${produtoSelecionado!.nome}'");
    try {
      String lote = loteController.text.trim();
      String quantidadeStr = quantidadeController.text.trim();
      String dataValidadeStr = dataValidadeController.text.trim();

      if (produtoSelecionado == null || lote.isEmpty || quantidadeStr.isEmpty || dataValidadeStr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Todos os campos são obrigatórios!"))
        );
        return;
      }

      int quantidade = int.tryParse(quantidadeStr) ?? 0;
      if (quantidade <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Quantidade deve ser um número válido!"))
        );
        return;
      }

      DateTime dataValidade = DateTime.parse(dataValidadeStr);

      final estoqueProvider = Provider.of<EstoqueProvider>(context, listen: false);
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

      final success = await estoqueProvider.cadastrarEstoque(
        produtoSelecionado!.id,
        lote,
        quantidade,
        dataValidade,
        authProvider.user!.token,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Estoque cadastrado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        _limparCampos();
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
        SnackBar(
          content: Text("Erro: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _limparCampos() {
    setState(() {
      produtoSelecionado = null;
      loteController.clear();
      quantidadeController.clear();
      dataValidadeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<EstoqueProvider, ProdutoProvider, AuthProvider>(
      builder: (context, estoqueProvider, produtoProvider, authProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF0F9FF),
          body: Stack(
            children: [
              Positioned(
                top: 42,
                left: 146,
                child: Image.asset("assets/images/cat.png", width: 111, height: 95),
              ),
              Positioned(
                top: 131,
                left: 88,
                child: Text(
                  "Cadastro de Estoque",
                  style: TextStyle(fontSize: 22, color: Color(0xFF020A22)),
                ),
              ),

              Positioned(
                top: 199,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: DropdownButtonFormField<Produto>(
                    value: produtoSelecionado,
                    decoration: InputDecoration(
                      labelText: "Selecionar Produto",
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF3B82F6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: produtoProvider.produtos.map((produto) {
                      return DropdownMenuItem<Produto>(
                        value: produto,
                        child: Text("${produto.nome} - ${produto.marca}"),
                      );
                    }).toList(),
                    onChanged: (Produto? newValue) {
                      setState(() {
                        produtoSelecionado = newValue;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                top: 275,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: loteController,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Lote",
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF3B82F6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 351,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: quantidadeController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Quantidade",
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF3B82F6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 427,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: dataValidadeController,
                    readOnly: true,
                    onTap: _selecionarData,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Data de validade",
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      suffixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF3B82F6)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 503,
                left: 94,
                child: ElevatedButton(
                  onPressed: estoqueProvider.isLoading ? null : () async {
                    await _cadastrarEstoque();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(205, 48),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: estoqueProvider.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text("+ Cadastrar", style: TextStyle(color: Color(0xFF020A22)),),
                ),
              ),
              Positioned(
                top: 720,
                left: 10,
                child: NavigatorMenu(selectedIndex: 1))
            ],
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