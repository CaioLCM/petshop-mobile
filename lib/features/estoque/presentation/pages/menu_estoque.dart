import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/cadastro_estoque_page.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/estoque_page.dart';
import 'package:petshop_mobile/features/home/presentation/pages/home_page.dart';
import 'package:petshop_mobile/features/perfil/presentation/pages/perfil_page.dart';

class MenuEstoque extends StatelessWidget {
  const MenuEstoque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(130),
                  bottomRight: Radius.circular(130),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: MediaQuery.of(context).size.width * 0.5 - 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFF0F9FF),
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage("assets/images/cat.png"),
                width: 111,
                height: 95,
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: MediaQuery.of(context).size.width * 0.5 - 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CadastroEstoquePage()),
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
              child: Text("Cadastro de Estoques"),
            ),
          ),
          Positioned(
            top: 427,
            left: MediaQuery.of(context).size.width * 0.5 - 100,
            child: ElevatedButton(
              onPressed: () {
               Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => EstoquePage()),
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
              child: Text("Edição de Estoque"),
            ),
          ),
          Positioned(
            top: 500,
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
              ),)
          ,
          Positioned(
            top: 720,
            left: 10,
            child: NavigatorMenu(selectedIndex: 1))
        ],
      ),
    );
  }
}
