import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';

class EdicaoProdutos extends StatelessWidget {
  const EdicaoProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: TextField(
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: 0,
                ),
                decoration: InputDecoration(
                  labelText: "Data de cadastro",
                  filled: true,
                  fillColor: Color(0xFFFCFCFC),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
            top: 579,
            left: 17,
            child: SizedBox(
              width: 360,
              height: 52,
              child: TextField(
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
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF60A5FA),
                    ), // borda azul quando não focado
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF3B82F6),
                    ), // borda azul escuro quando focado
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
            left: 94,
            child: ElevatedButton(
              onPressed: () {
/*                 Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => CadastroEstoquePage()),
                ); */
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
              child: Text("Salvar alterações"),
            ),
          ),
          Positioned(
            top: 720,
            left: 10,
            child: NavigatorMenu())
        ],
      ),
    );
  }
}
