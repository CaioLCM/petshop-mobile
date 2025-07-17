
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/estoque_provider.dart';
import '../../domain/entities/estoque.dart';
import '../../../produtos/presentation/providers/produto_provider.dart';

class RegistrarBaixaPage extends StatefulWidget {
  const RegistrarBaixaPage({Key? key}) : super(key: key);

  @override
  State<RegistrarBaixaPage> createState() => _RegistrarBaixaPageState();
}

class _RegistrarBaixaPageState extends State<RegistrarBaixaPage> {
  bool _nomesPreenchidos = false;
  Estoque? estoqueSelecionado;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final estoqueProvider = Provider.of<EstoqueProvider>(context);
    final estoques = estoqueProvider.estoques;
    if (estoqueSelecionado != null && estoques.isNotEmpty) {
      final match = estoques.firstWhere(
        (e) => e.id == estoqueSelecionado!.id,
        orElse: () => estoques.first,
      );
      if (match.id == estoqueSelecionado!.id) {
        estoqueSelecionado = match;
      } else {
        estoqueSelecionado = null;
      }
    }
  }
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController motivoController = TextEditingController();
  TextEditingController observacoesController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    quantidadeController.dispose();
    motivoController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estoqueProvider = Provider.of<EstoqueProvider>(context);
    final produtoProvider = Provider.of<ProdutoProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final estoques = estoqueProvider.estoques;

    if (!_nomesPreenchidos && estoques.isNotEmpty && produtoProvider.produtos.isNotEmpty) {
      estoqueProvider.preencherNomeProduto(produtoProvider.produtos);
      setState(() {
        _nomesPreenchidos = true;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFF60A5FA), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selecione o lote para registrar baixa:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF020A22),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<Estoque>(
                value: estoqueSelecionado,
                items: estoques.map((e) {
                  return DropdownMenuItem<Estoque>(
                    value: e,
                    child: Text('Lote: ${e.lote}  |  ${e.produtoNome}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    estoqueSelecionado = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Lote / Produto',
                  filled: true,
                  fillColor: Color(0xFFFCFCFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  filled: true,
                  fillColor: Color(0xFFFCFCFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: motivoController,
                decoration: InputDecoration(
                  labelText: 'Motivo',
                  filled: true,
                  fillColor: Color(0xFFFCFCFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: observacoesController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Observações',
                  filled: true,
                  fillColor: Color(0xFFFCFCFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (errorMessage != null)
                Text(errorMessage!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (estoqueSelecionado == null || quantidadeController.text.isEmpty) {
                      setState(() {
                        errorMessage = 'Selecione o produto/lote e informe a quantidade.';
                      });
                      return;
                    }
                    final quantidade = int.tryParse(quantidadeController.text);
                    if (quantidade == null || quantidade <= 0) {
                      setState(() {
                        errorMessage = 'Quantidade inválida.';
                      });
                      return;
                    }
                  final motivo = motivoController.text.trim();
                  final observacoes = observacoesController.text.trim();
                  final token = authProvider.user?.token ?? '';
                  setState(() { errorMessage = null; });

                  final sucesso = await estoqueProvider.registrarBaixa(
                    estoqueSelecionado!.id,
                    quantidade,
                    motivo,
                    token,
                    observacoes: observacoes,
                    itemEstoque: estoqueSelecionado!.produtoNome,
                  );
                    if (sucesso) {
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        errorMessage = estoqueProvider.error ?? 'Erro ao registrar baixa.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 45),
                    backgroundColor: Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black.withOpacity(0.25),
                    side: BorderSide(
                      color: Color(0xFF60A5FA),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'Registrar baixa',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF020A22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
