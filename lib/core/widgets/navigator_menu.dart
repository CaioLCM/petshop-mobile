import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/estoque_page.dart';
import 'package:petshop_mobile/features/perfil/presentation/pages/perfil_page.dart';

class NavigatorMenu extends StatelessWidget {
  const NavigatorMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: Color(0xFF1E3A8A),
      ),
      width: 373,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PerfilPage()));
            },
            icon: Icon(
              Icons.local_offer,
              color: Color(0xFFF0F9FF),
              size: 33.62,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EstoquePage()));
            },
            icon: Icon(
              Icons.credit_card,
              color: Color(0xFFF0F9FF),
              size: 33.62,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: Color(0xFFF0F9FF), size: 33.62),
          ),
        ],
      ),
    );
  }
}
