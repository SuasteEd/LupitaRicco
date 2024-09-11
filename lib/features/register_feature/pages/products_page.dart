import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lupita_ricco/features/register_feature/services/register_controller.dart';
import 'package:lupita_ricco/utils/colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = RegisterController();
  Stream? menuStream;

  Widget _sweetList() {
    return StreamBuilder(
      stream: menuStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.data.docs.isEmpty) {
            return const Center(child: Text('No hay datos'));
          }
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs[0]['Menu'].length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data.docs[0]['Menu'][index]),
              subtitle: Text(snapshot.data.docs[0]['Menu'][index]),
            );
          },
        );
        // Text('Datos: ${snapshot.data.docs[0]['Menu'][0]}');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  void getMenu() async {
    menuStream = await controller.fireController.getSweetMenu();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              // onTap: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CreateUser(),
              //   ),
              // ),
              child: Container(
                height: 45,
                width: 170,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(2, 3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.black),
                    const SizedBox(width: 10),
                    Text('Agregar usuario',
                        style: GoogleFonts.dosis(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(2, 1),
                  ),
                ],
              ),
              child: _sweetList(),
            ),
          ],
        ),
      ),
    );
  }
}
