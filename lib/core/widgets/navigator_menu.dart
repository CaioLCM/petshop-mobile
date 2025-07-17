import 'package:flutter/material.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/estoque_page.dart';
import 'package:petshop_mobile/features/estoque/presentation/pages/menu_estoque.dart';
import 'package:petshop_mobile/features/perfil/presentation/pages/perfil_page.dart';
import 'package:petshop_mobile/features/produtos/presentation/pages/menu_produto.dart';

class NavigatorMenu extends StatelessWidget {
  final int selectedIndex;
  const NavigatorMenu({super.key, required this.selectedIndex});

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
          _buildNavIcon(
            context,
            icon_selected: Icons.local_offer,
            icon: Icons.local_offer_outlined,
            selected: selectedIndex == 0,
            onTap: () {
              if (selectedIndex != 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => MenuProduto()),
                );
              }
            },
          ),
          _buildNavIcon(
            context,
            icon_selected: Icons.inventory_2,
            icon: Icons.inventory_2_outlined,
            selected: selectedIndex == 1,
            onTap: () {
              if (selectedIndex != 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => MenuEstoque()),
                );
              }
            },
          ),
          _buildNavIcon(
            context,
            icon_selected: Icons.person,
            icon: Icons.person_outlined,
            selected: selectedIndex == 2,
            onTap: () {
              if (selectedIndex != 2) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => PerfilPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context, {
    required IconData icon,
    required IconData icon_selected,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          selected ? icon_selected : icon,
          color: Color(0xFFF0F9FF),
          size: 33.62,
        ),
      ),
    );
  }
}
