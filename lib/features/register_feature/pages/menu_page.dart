import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/images/logos/sweet_logo.png',
                  height: 200),
            ),
            Text('Administrador',
                style: GoogleFonts.shadowsIntoLight(
                    fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MenuCard(
                  title: 'Usuarios',
                  image: 'assets/icons/user.png',
                  onTap: () => Navigator.pushNamed(context, '/users'),
                ),
                MenuCard(
                  title: 'Productos',
                  image: 'assets/icons/bake.png',
                  onTap: () => Navigator.pushNamed(context, '/products'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  const MenuCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0.2, 4)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(image, height: 100),
            const SizedBox(height: 10),
            Text(title,
                style: GoogleFonts.dosis(
                    fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
