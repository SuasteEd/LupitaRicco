import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lupita_ricco/utils/colors.dart';
import '../services/sweet_service.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = SweetService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryVariant,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.holiday_village),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            color: primaryVariant,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTime.now().hour < 12 ? 'Buenos días' : 'Buenas tardes',
                  style: GoogleFonts.libreBaskerville(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lupita Ricco, hoy es un buen día',
                  style: GoogleFonts.dosis(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Menú',
                      style: GoogleFonts.dosis(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemExtent: MediaQuery.of(context).size.width / 5.5,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                debugPrint(index.toString());
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    service.menu[index].image,
                                    width: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(service.menu[index].name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dosis(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: service.menu.length),
                    ),
                    Text(
                      'Cafés fríos',
                      style: GoogleFonts.dosis(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 100,
                      color: Colors.red,
                    ),
                    Text(
                      'Cafés calientes',
                      style: GoogleFonts.dosis(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
