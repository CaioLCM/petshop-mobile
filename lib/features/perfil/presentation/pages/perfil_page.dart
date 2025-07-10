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
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        _preencherCampos();
      }
    });
  }

  void _preencherCampos() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user != null) {
      nomeController.text = user.nome;
      emailController.text = user.email;
      codigoController.text = user.codigoFuncionario ?? "";
    }
  }

  Future<void> _atualizarPerfil() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Nome e email são obrigatórios!")));
      return;
    }

    if (senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Informe sua senha atual para confirmar as alterações!",
          ),
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.updateProfile(nome, email, senha);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Perfil atualizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
      senhaController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro: ${authProvider.error ?? 'Senha incorreta ou erro desconhecido'}",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.user;

        print("DEBUG - PerfilPage: user = $user");
        print("DEBUG - PerfilPage: user?.nome = ${user?.nome}");
        print("DEBUG - PerfilPage: user?.permissao = ${user?.permissao}");

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
                        controller: emailController,
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
                        onPressed:
                            authProvider.isLoading
                                ? null
                                : () async {
                                  await _atualizarPerfil();
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
                    ),
                    NavigatorMenu(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    codigoController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}
