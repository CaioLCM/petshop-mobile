import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import '../providers/produto_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({super.key});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController precoController = TextEditingController(); // ← ADICIONAR
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  Future<void> _cadastrarProduto() async {
    try {
      String nome = nomeController.text.trim();
      String tipo = tipoController.text.trim();
      String marca = marcaController.text.trim();
      String precoStr = precoController.text.trim(); // ← ADICIONAR
      String quantidadeStr = quantidadeController.text.trim();
      String descricao = descricaoController.text.trim();

      if (nome.isEmpty || tipo.isEmpty || marca.isEmpty || precoStr.isEmpty || quantidadeStr.isEmpty) { // ← ADICIONAR precoStr
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Todos os campos são obrigatórios!"))
        );
        return;
      }

      double preco = double.tryParse(precoStr) ?? 0; // ← ADICIONAR
      if (preco <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Preço deve ser um número válido!"))
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

      final produtoProvider = Provider.of<ProdutoProvider>(context, listen: false);
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

      final success = await produtoProvider.cadastrarProduto(
        nome,
        tipo,
        marca,
        preco,      // ← ADICIONAR
        quantidade,
        descricao,
        authProvider.user!.token,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Produto cadastrado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        _limparCampos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro: ${produtoProvider.error}"),
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
    nomeController.clear();
    tipoController.clear();
    marcaController.clear();
    precoController.clear(); // ← ADICIONAR
    quantidadeController.clear();
    descricaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProdutoProvider>(
      builder: (context, produtoProvider, child) {
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
                  "Cadastro de Produtos",
                  style: TextStyle(fontSize: 22, color: Color(0xFF020A22)),
                ),
              ),
              Positioned(
                top: 199,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: nomeController,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Nome do produto",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                    controller: tipoController,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Tipo",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
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
                    controller: marcaController,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Marca",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // ← NOVO CAMPO PREÇO
              Positioned(
                top: 427,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: precoController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Preço",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 503, // ← POSIÇÃO MOVIDA PARA BAIXO
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 579, // ← POSIÇÃO MOVIDA PARA BAIXO
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: descricaoController,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Descrição",
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 655, // ← POSIÇÃO MOVIDA PARA BAIXO
                left: 94,
                child: ElevatedButton(
                  onPressed: produtoProvider.isLoading ? null : () async {
                    await _cadastrarProduto();
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
                  child: produtoProvider.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text("+ Cadastrar"),
                ),
              ),
              Positioned(
                top: 720, // ← POSIÇÃO MOVIDA PARA BAIXO
                left: 10,
                child: NavigatorMenu())
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    tipoController.dispose();
    marcaController.dispose();
    precoController.dispose(); // ← ADICIONAR
    quantidadeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }
}