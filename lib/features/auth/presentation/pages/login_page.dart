import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Column(
        children: [
          Text(
            "PetGateu",
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w900,
              fontSize: 48,
              letterSpacing: 0,
              color: Color(0xFF020A22),
            ),
          ),
          Image(
            image: AssetImage("assets/images/cat.png"),
            width: 111,
            height: 95,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Login",
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                hintText: "Senha",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(205, 48),
              foregroundColor: Color(0xFF020A22),
              backgroundColor: Color(0xFF3B82F6),
            ),
            child: Text("Entrar"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ainda não tem uma conta?",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0,
                  color: Color(0xFF020A22)
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => SignupPage()));
                },
                child: Text(
                  "Criar agora",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
