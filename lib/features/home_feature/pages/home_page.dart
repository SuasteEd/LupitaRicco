import 'package:flutter/material.dart';
import 'package:lupita_ricco/utils/colors.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Column(
        children: [
          Container(
            color: primaryVariant,
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTime.now().hour < 12 ? 'Buenos días' : 'Buenas tardes',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text('Lupita Ricco, hoy es un buen día'),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: primaryVariant,
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Menú',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              }),
                            ),
                            Container(
                              height: 200,
                              color: Colors.amber,
                            ),
                            Container(
                              height: 200,
                              color: Colors.black,
                            ),
                             Container(
                              height: 200,
                              color: Colors.amber,
                            ),
                            Container(
                              height: 200,
                              color: Colors.black,
                            ),
                             Container(
                              height: 200,
                              color: Colors.amber,
                            ),
                            Container(
                              height: 200,
                              color: Colors.black,
                            ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: 4,
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (context, index) {
                            //       return ListTile(
                            //         title: Text('Item $index'),
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
