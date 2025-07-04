import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Image.asset("assets/images/cat.png", width: 191, height: 155),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Criar uma conta",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      letterSpacing: 0,
                      color: Color(0xFF020A22)
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              decoration: InputDecoration(
                labelText: "Nome",
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                labelText: "Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                labelText: "Senha",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                labelText: "Confirme sua senha",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 140.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFF3B82F6),
                foregroundColor: Color(0xFF020A22),
                fixedSize: Size(205, 48)
              ), 
              child: Text("Criar Conta", style: TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0
              ),),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Já possui uma conta?", style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0
                )),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
              }, child: Text("Faça login", style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0,
                color: Color(0xFF3B82F6)
                ))),
            ],
          ),
        ],
      ),
    );
  }
}
