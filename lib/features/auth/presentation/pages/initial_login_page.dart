import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/signup_page.dart';

class InitialLoginPage extends StatelessWidget {
  const InitialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF0F9FF), Color(0xFF909599)],
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 231, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage("assets/images/cat.png"),
                        width: 70,
                        height: 80,
                      ),
                      SizedBox(width: 0),
                      Text(
                        "PetGateu",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                          fontSize: 48,
                          color: Color(0xFF020A22),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 140, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(343, 44),
                      backgroundColor: Color(0xFF3B82F6),
                      foregroundColor: Color(0xFF020A22),
                      side: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Fazer login",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(343, 44),
                      backgroundColor: Color(0xFFFCFCFC),
                      foregroundColor: Color(0xFF020A22),
                      side: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                    ),
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
