//tela 1 logo com fundo de cachorro
import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/auth/presentation/pages/initial_login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => InitialLoginPage()));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/dog.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment(-0.29, 0.0),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    colors: [Color(0x6660A5FA), Color(0xFF1E3A8A)],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset(
                        "assets/images/cat.png",
                        width: 138,
                        height: 164,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(120),
                        child: Text(
                          "Pet\nGateu",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: 48,
                            color: Color(0xFF020A22),
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
