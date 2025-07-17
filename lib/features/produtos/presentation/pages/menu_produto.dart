import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import 'package:petshop_mobile/features/home/presentation/pages/home_page.dart';
import 'package:petshop_mobile/features/produtos/presentation/pages/cadastro_produto.dart';
import 'package:petshop_mobile/features/produtos/presentation/pages/edicao_produtos.dart';

class MenuProduto extends StatelessWidget {
  const MenuProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Stack(
        children: [
          Positioned(
            top: 358,
            left: 94,
            child: ElevatedButton(
              onPressed: () {
               Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => EdicaoProdutos()),
                ); 
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(205, 48),
                foregroundColor: Color(0xFF020A22),
                backgroundColor: Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text("Edição de Produtos"),
            ),
          ),
          Positioned(
            top: 426,
            left: 94,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CadastroProduto()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(205, 48),
                foregroundColor: Color(0xFF020A22),
                backgroundColor: Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text("Cadastro de Produtos"),
            ),
          ),
          Positioned(
            top: 490,
            left: 173,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
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
              ),),
          Positioned(
            top: 720,
            left: 10,
            child: NavigatorMenu(selectedIndex: 0)),
        ],
      ),
    );
  }
}
