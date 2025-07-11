import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import '../providers/produto_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/produto.dart';

class EdicaoProdutos extends StatefulWidget {
  const EdicaoProdutos({super.key});

  @override
  State<EdicaoProdutos> createState() => _EdicaoProdutosState();
}

class _EdicaoProdutosState extends State<EdicaoProdutos> {
  TextEditingController tipoController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController dataCadastroController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  Produto? produtoSelecionado;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).listarProdutos();
    });
  }

  void _preencherCampos(Produto produto) {
    setState(() {
      produtoSelecionado = produto;
      tipoController.text = produto.tipo;
      marcaController.text = produto.marca;
      precoController.text = produto.preco.toString();
      quantidadeController.text = produto.quantidade.toString();
      dataCadastroController.text = produto.dataCadastro.toString().split(' ')[0];
      descricaoController.text = produto.descricao;
    });
  }

  void _limparCampos() {
    setState(() {
      produtoSelecionado = null;
      tipoController.clear();
      marcaController.clear();
      precoController.clear();
      quantidadeController.clear();
      dataCadastroController.clear();
      descricaoController.clear();
    });
  }

  Future<void> _editarProduto() async {
    if (produtoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selecione um produto para editar!")),
      );
      return;
    }

    try {
      String tipo = tipoController.text.trim();
      String marca = marcaController.text.trim();
      String precoStr = precoController.text.trim();
      String quantidadeStr = quantidadeController.text.trim();
      String descricao = descricaoController.text.trim();

      if (tipo.isEmpty || marca.isEmpty || precoStr.isEmpty || quantidadeStr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Todos os campos são obrigatórios!")),
        );
        return;
      }

      double preco = double.tryParse(precoStr) ?? 0;
      if (preco <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Preço deve ser um número válido!")),
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

      final success = await produtoProvider.editarProduto(
        produtoSelecionado!.id,
        produtoSelecionado!.nome,
        tipo,
        marca,
        preco,
        quantidade,
        descricao,
        authProvider.user!.token,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Produto editado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        _limparCampos();
        await produtoProvider.listarProdutos();
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
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
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
                  "Edição de Produtos",
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
                    items: produtoProvider.produtos.map((produto) {
                      return DropdownMenuItem<Produto>(
                        value: produto,
                        child: Text(
                          produto.nome,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Produto? produto) {
                      if (produto != null) {
                        _preencherCampos(produto);
                      }
                    },
                    hint: Text(
                      produtoProvider.isLoading
                          ? "Carregando produtos..."
                          : produtoProvider.produtos.isEmpty
                              ? "Nenhum produto encontrado"
                              : "Selecione um produto",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.grey[600],
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
                top: 503,
                left: 17,
                child: SizedBox(
                  width: 360,
                  height: 52,
                  child: TextField(
                    controller: dataCadastroController,
                    enabled: false,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      labelText: "Data de cadastro",
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 579,
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
                top: 655,
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
                top: 731,
                left: 94,
                child: ElevatedButton(
                  onPressed: produtoProvider.isLoading ? null : () async {
                    await _editarProduto();
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
                      : Text("Salvar Alterações"),
                ),
              ),
              Positioned(
                top: 736,
                left: 10,
                child: NavigatorMenu(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    tipoController.dispose();
    marcaController.dispose();
    precoController.dispose();
    quantidadeController.dispose();
    dataCadastroController.dispose();
    descricaoController.dispose();
    super.dispose();
  }
}