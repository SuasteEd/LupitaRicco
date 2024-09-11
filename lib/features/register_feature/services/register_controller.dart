import 'package:flutter/material.dart';
import 'package:lupita_ricco/core/services/firebase_service.dart';

class RegisterController {
  final fireController = FirebaseService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  final List<String> roles = ['Administrador', 'Empleado'];
  final List<String> areas = ['Cafetería', 'Grill'];

  final formKeyUser = GlobalKey<FormState>();

  Future<void> createUser() async {
    await fireController.createUser(
        nameController.text,
        emailController.text,
        passwordController.text,
        areaController.text,
        roleController.text == 'Administrador' ? 1 : 2);
  }

  Future<void> updateUser(String id, Map<String, dynamic> map) async {
    await fireController.updateUser(id, map);
  }

  Future<void> deleteUser(String id) async {
    await fireController.deleteUser(id);
  }
}
