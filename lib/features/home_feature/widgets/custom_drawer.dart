import 'package:flutter/material.dart';
import 'package:lupita_ricco/utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryVariant,
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.white,
            child: const Center(
              child: Text(
                'Lupita Ricco',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
          ListTile(
            title: const Text('Cerrar sesión'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
