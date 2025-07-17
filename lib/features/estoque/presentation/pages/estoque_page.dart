import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/cadastro_estoque_page.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/edicao_estoque_page.dart';
import '../providers/estoque_provider.dart';
import 'registrar_baixa_page.dart';
import '../../../produtos/presentation/providers/produto_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/estoque.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  TextEditingController pesquisaController = TextEditingController();
  List<Estoque> estoquesFiltrados = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarEstoques();
    });
  }

  Future<void> _carregarEstoques() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final estoqueProvider = Provider.of<EstoqueProvider>(
      context,
      listen: false,
    );
    final produtoProvider = Provider.of<ProdutoProvider>(
      context,
      listen: false,
    );

    if (authProvider.user != null) {
      await estoqueProvider.listarEstoque(authProvider.user!.token);
      estoqueProvider.preencherNomeProduto(produtoProvider.produtos);
      _filtrarEstoques();
    }
  }

  void _filtrarEstoques() {
    final estoqueProvider = Provider.of<EstoqueProvider>(
      context,
      listen: false,
    );
    String termo = pesquisaController.text.toLowerCase();

    setState(() {
      if (termo.isEmpty) {
        estoquesFiltrados = estoqueProvider.estoques;
      } else {
        estoquesFiltrados =
            estoqueProvider.estoques.where((estoque) {
              return estoque.produtoNome.toLowerCase().contains(termo) ||
                  estoque.lote.toLowerCase().contains(termo);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EstoqueProvider, AuthProvider>(
      builder: (context, estoqueProvider, authProvider, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF0F9FF),
          body: Stack(
            children: [
              Positioned(
                top: 42,
                left: 143,
                child: Image.asset(
                  "assets/images/cat.png",
                  width: 111,
                  height: 95,
                ),
              ),
              Positioned(
                top: 131,
                left: 158,
                child: Text(
                  "Estoque",
                  style: TextStyle(fontSize: 22, color: Color(0xFF020A22)),
                ),
              ),
              Positioned(
                top: 187,
                left: 19,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => CadastroEstoquePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(175, 40.98),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "+ Cadastrar",
                        style: TextStyle(color: Color(0xFF020A22)),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RegistrarBaixaPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(175, 40.98),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Registrar baixa",
                        style: TextStyle(color: Color(0xFF020A22)),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 248,
                left: 19,
                child: SizedBox(
                  width: 355,
                  height: 44,
                  child: TextField(
                    controller: pesquisaController,
                    onChanged: (value) => _filtrarEstoques(),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                    decoration: InputDecoration(
                      labelText: "Pesquisar",
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      suffixIcon: Icon(Icons.search, color: Color(0xFF60A5FA)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF60A5FA),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 310,
                left: 19,
                right: 19,
                bottom: 80,
                child:
                    estoqueProvider.isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF3B82F6),
                          ),
                        )
                        : estoquesFiltrados.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Nenhum estoque encontrado",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: estoquesFiltrados.length,
                          itemBuilder: (context, index) {
                            final estoque = estoquesFiltrados[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFCFCFC),
                                    Color(0xCC969696),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF60A5FA),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      "assets/images/image_estoque.png",
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          color: Color(0xFFF0F9FF),
                                          child: Image.asset(
                                            "assets/images/estoque_image.png",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Nome: ${estoque.produtoNome}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF020A22),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Nº do lote: ${estoque.lote}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF020A22),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Quantidade: ${estoque.quantidade}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF020A22),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (estoque.produtoMarca.isNotEmpty)
                                          Text(
                                            "Marca: ${estoque.produtoMarca}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF020A22),
                                            ),
                                          ),
                                        if (estoque.produtoTipo.isNotEmpty)
                                          Text(
                                            "Tipo: ${estoque.produtoTipo}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF020A22),
                                            ),
                                          ),
                                        Text(
                                          "Data de cadastro: ${estoque.dataCadastro.toString().split(' ')[0]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF020A22),
                                          ),
                                        ),
                                        Text(
                                          "Data de validade: ${estoque.dataValidade.toString().split(' ')[0]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF020A22),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                final result = await Navigator.of(
                                                  context,
                                                ).push(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) =>
                                                            EdicaoEstoquePage(
                                                              estoque: estoque,
                                                            ),
                                                  ),
                                                );
                                                if (result == true) {
                                                  _carregarEstoques();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(60, 35),
                                                backgroundColor: Color(
                                                  0xFF3B82F6,
                                                ),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                elevation: 3,
                                                shadowColor: Colors.black
                                                    .withOpacity(0.25),
                                                side: BorderSide(
                                                  color: Color(0xFF60A5FA),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                "Editar",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF020A22),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            );
                          },
                        ),
              ),
              Positioned(
                top: 700,
                left: 10,
                child: NavigatorMenu(selectedIndex: 1),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }
}
