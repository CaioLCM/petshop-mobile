import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late final AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  Future<void> _registerUser() async {
    try {
      print("DEBUG - Iniciando validações...");

      String nome = nameController.text.trim();
      String email = emailController.text.trim();
      String senha = passwordController.text;
      String confirmaSenha = confirmPasswordController.text;

      print("DEBUG - Dados: nome=$nome, email=$email");

      if (nome.length < 2 || nome.length > 50 || nome.contains(' ')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Nome deve ter 2-50 caracteres SEM ESPAÇOS!")),
        );
        return;
      }

      if (email.contains(' ') || !email.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email inválido - não pode ter espaços!")),
        );
        return;
      }

      if (passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Senha deve ter no mínimo 6 caracteres!")),
        );
        return;
      }

      bool temMinuscula = senha.contains(RegExp(r'[a-z]'));
      bool temMaiuscula = senha.contains(RegExp(r'[A-Z]'));
      bool temNumero = senha.contains(RegExp(r'[0-9]'));

      if (!temMinuscula || !temMaiuscula || !temNumero) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Senha deve ter pelo menos: 1 minúscula, 1 MAIÚSCULA e 1 número!",
            ),
          ),
        );
        return;
      }

      if (senha != confirmaSenha) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("As senhas não coincidem!")));
        return;
      }

      print("DEBUG - Todas validações passaram! Chamando API...");

      final result = await authRemoteDataSourceImpl.register(
        nome,
        email,
        senha,
        confirmaSenha,
      );

      print("DEBUG - Resultado: $result");

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    } catch (e) {
      print("DEBUG - Erro: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(client: http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F9FF),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Image.asset(
              "assets/images/cat.png",
              width: 191,
              height: 155,
            ),
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
                      color: Color(0xFF020A22),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              controller: nameController,
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: TextField(
              controller: emailController,
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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF60A5FA),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF3B82F6),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
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
              controller: passwordController,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                labelText: "Senha",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF60A5FA),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF3B82F6),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
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
              controller: confirmPasswordController,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0,
              ),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFCFCFC),
                labelText: "Confirme sua senha",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF60A5FA),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF3B82F6),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF60A5FA)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 120.0),
            child: ElevatedButton(
              onPressed: () async {
                await _registerUser();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFF3B82F6),
                foregroundColor: Color(0xFF020A22),
                fixedSize: Size(205, 48),
                elevation: 5,
              ),
              child: Text(
                "Criar Conta",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Já possui uma conta?",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text(
                  "Faça login",
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
            ],
          ),
        ],
      ),
    );
  }
}
