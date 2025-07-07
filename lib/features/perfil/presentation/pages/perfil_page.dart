import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Stack(
        children: [
          Positioned(
            top: 84,
            left: 149,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 153,
            left: 214,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 204,
            left: 72,
            child: Text(
              "Mel Cabral Fiore Brito",
              style: TextStyle(color: Color(0xFF020A22), fontSize: 24),
            ),
          ),
          Positioned(
            top: 260,
            left: 17,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Tipo de usuário: ",
                    style: TextStyle(color: Color(0xFF020A22), fontSize: 16),
                  ),
                  TextSpan(
                    text: "Administrador",
                    style: TextStyle(color: Color(0xFF60A5FA), fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 294,
            left: 17,
            child: Column(
              children: [
                SizedBox(
                  height: 52,
                  width: 360,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      hintText: "Nome",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF60A5FA),
                        ), // borda azul quando não focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF3B82F6),
                        ), // borda azul escuro quando focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  height: 52,
                  width: 360,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      hintText: "E-mail",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF60A5FA),
                        ), // borda azul quando não focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF3B82F6),
                        ), // borda azul escuro quando focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  height: 52,
                  width: 360,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      hintText: "Codigo",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF60A5FA),
                        ), // borda azul quando não focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF3B82F6),
                        ), // borda azul escuro quando focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  height: 52,
                  width: 360,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFCFCFC),
                      hintText: "Senha",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF60A5FA),
                        ), // borda azul quando não focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xFF3B82F6),
                        ), // borda azul escuro quando focado
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => PerfilPage()),
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
                    child: Text("Atualizar perfil"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Color(0xFF3B82F6),),
                      Text(
                        "Sair da conta",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ),
                NavigatorMenu()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
