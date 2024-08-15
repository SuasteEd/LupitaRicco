import 'package:lupita_ricco/features/home_feature/models/sweet_menu.dart';

class SweetService {
  //Menu
  final List<SweetMenu> menu = [
    SweetMenu(name: 'Cafés', image: 'assets/icons/coffee.png'),
    SweetMenu(name: 'Bebidas\ncalientes', image: 'assets/icons/tea.png'),
    SweetMenu(name: 'Bebidas\nfrías', image: 'assets/icons/frappe.png'),
    SweetMenu(name: 'Postres\n(al plato)', image: 'assets/icons/cake.png'),
    SweetMenu(name: 'Postres', image: 'assets/icons/sweets.png'),
  ];
}
