import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';

class EstoquePage extends StatelessWidget {
  const EstoquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 42,
            left: 143,
            child: Image.asset("assets/images/cat.png", width: 111, height: 95),
          ),
          Positioned(
            top: 131,
            left: 158,
            child: Text(
              "Estoque",
              style: TextStyle(fontSize: 22, color: Color(0xFF020A22)),
            ),
          ),
          Positioned(top: 700, left: 10, child: NavigatorMenu()),
          Positioned(
            top: 187,
            left: 19,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => EstoquePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(175, 40.98),
                    foregroundColor: Color(0xFF020A22),
                    backgroundColor: Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text("+ Cadastrar"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => EstoquePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(175, 40.98),
                    foregroundColor: Color(0xFF020A22),
                    backgroundColor: Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text("Registrar baixa"),
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
            top: 246,
            left: 320,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ),
        ],
      ),
    );
  }
}
