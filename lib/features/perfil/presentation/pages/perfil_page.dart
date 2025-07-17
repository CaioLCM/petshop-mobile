import 'package:flutter/material.dart';
import 'package:petshop_mobile/core/widgets/navigator_menu.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:petshop_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;
      if (user != null) {
        nomeController.text = user.nome;
        emailController.text = user.email;
        codigoController.text = user.id;
      }
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    codigoController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> _atualizarPerfil() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final success = await authProvider.updateProfile(
        nome: nomeController.text,
        email: emailController.text,
        senha: senhaController.text,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil atualizado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar perfil: ${authProvider.error ?? 'Erro desconhecido'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar perfil: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.user;
        return Scaffold(
          backgroundColor: Color(0xFFF0F9FF),
          body: Stack(
            children: [
              Positioned(
                top: 204,
                left: 17,
                child: Text(
                  user?.nome ?? "Nome não encontrado",
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
                        style: TextStyle(
                          color: Color(0xFF020A22),
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: user?.permissao ?? 'N/A',
                        style: TextStyle(
                          color: Color(0xFF60A5FA),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 294,
                left: 17,
                child: Container(
                  width: 360,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 52,
                        width: 360,
                        child: TextField(
                          controller: nomeController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            hintText: "Nome",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
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
                              ),
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
                      SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        width: 360,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            hintText: "E-mail",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
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
                              ),
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
                      SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        width: 360,
                        child: TextField(
                          controller: codigoController,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            hintText: "Codigo",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
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
                              ),
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
                      SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        width: 360,
                        child: TextField(
                          controller: senhaController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFCFCFC),
                            hintText: "Senha",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF60A5FA),
                              ),
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
                              ),
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
                      SizedBox(height: 60),
                      SizedBox(
                        width: 205,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () async {
                                  await _atualizarPerfil();
                                },
                          style: ElevatedButton.styleFrom(
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 105,),
                          Icon(Icons.exit_to_app, color: Color(0xFF3B82F6)),
                          TextButton(
                            onPressed: () {
                              authProvider.logout();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            child: Text(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 720,
                left: 10,
                child: NavigatorMenu(selectedIndex: 2),
              ),
            ],
          ),
        );
      },
    );
  }
}