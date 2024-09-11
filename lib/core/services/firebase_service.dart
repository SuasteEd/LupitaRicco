import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  //GET
  final users = FirebaseFirestore.instance.collection('users');
  final sweetMenu = FirebaseFirestore.instance.collection('sweetMenu');
  final platedDesserts =
      FirebaseFirestore.instance.collection('plated Desserts');
  final hotDrinks = FirebaseFirestore.instance.collection('hotDrinks');
  final coldDrinks = FirebaseFirestore.instance.collection('coldDrinks');
  final desserts = FirebaseFirestore.instance.collection('desserts');
  final hotCoffee = FirebaseFirestore.instance.collection('hotCoffee');
  final coldCoffee = FirebaseFirestore.instance.collection('coldCoffee');

  //POST

  //create user
  Future<void> createUser(
      String name, String email, String password, String area, int role) async {
    try {
      await users.add({
        'area': area,
        'name': name,
        'username': email,
        'password': password,
        'role': role,
        'active': true,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  //update user
  Future<void> updateUser(String id, Map<String, dynamic> map) async {
    try {
      await users.doc(id).update(map);
    } catch (e) {
      print(e);
    }
  }

  //Delete user
  Future<void> deleteUser(String id) async {
    try {
      await users.doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  //Get user
  Future<Stream<QuerySnapshot>> getUsers() async {
    try {
      return users.snapshots();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //create sweetMenu
  //get sweetMenu
  Future<Stream<QuerySnapshot>> getSweetMenu() async {
    try {
      return sweetMenu.snapshots();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  //update sweetMenu

  //create platedDesserts

  //create hotDrinks

  //create coldDrinks

  //create desserts

  //create hotCoffee

  //create coldCoffee

  //PUT

  //DELETE
}
