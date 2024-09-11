import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lupita_ricco/core/widgets/add_button.dart';
import 'package:lupita_ricco/core/widgets/custom_drop_down_button.dart';
import 'package:lupita_ricco/core/widgets/custom_text_field.dart';
import 'package:lupita_ricco/features/register_feature/services/register_controller.dart';
import 'package:lupita_ricco/utils/colors.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final controller = RegisterController();
  Stream? userStream;

  Widget _userList() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.data.docs.isEmpty) {
            return const Center(child: Text('No hay usuarios'));
          }
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: snapshot.data.docs[index]['role'] == 1
                    ? Colors.green[100]
                    : Colors.yellow[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(snapshot.data.docs[index]['name']),
                subtitle: Text(snapshot.data.docs[index]['username']),
                trailing: Switch(
                  value: snapshot.data.docs[index]['active'],
                  activeColor: primaryVariant,
                  activeTrackColor: primary,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  onChanged: (value) {
                    controller.fireController
                        .updateUser(snapshot.data.docs[index].id, {
                      'active': value,
                    });
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateUser(user: snapshot.data.docs[index]),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() async {
    userStream = await controller.fireController.getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateUser(),
                ),
              ),
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
              child: _userList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateUser extends StatefulWidget {
  final dynamic user;
  const CreateUser({super.key, this.user});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final controller = RegisterController();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (widget.user != null) {
      controller.nameController.text = widget.user['name'];
      controller.emailController.text = widget.user['username'];
      controller.passwordController.text = widget.user['password'];
      controller.areaController.text = widget.user['area'];
      controller.roleController.text = widget.user['role'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.user != null
                          ? 'Editar usuario'
                          : 'Agregar usuario',
                      style: GoogleFonts.dosis(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  if (widget.user != null)
                    InkWell(
                      onTap: () {
                        controller.fireController.deleteUser(widget.user.id);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete_outlined, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Eliminar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                  key: controller.formKeyUser,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Nombre',
                        validator: true,
                        controller: controller.nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Nombre de usuario',
                        validator: true,
                        controller: controller.emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: 'Contraseña',
                        validator: true,
                        controller: controller.passwordController,
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownField(
                        label: 'Área',
                        controller: controller.areaController,
                        value: widget.user != null ? widget.user['area'] : null,
                        items: controller.areas.map((area) {
                          return DropdownMenuItem(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Seleccione un área';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownField(
                        label: 'Rol',
                        controller: controller.roleController,
                        value: widget.user != null
                            ? widget.user['role'] == 1
                                ? 'Administrador'
                                : 'Empleado'
                            : null,
                        items: controller.roles.map((area) {
                          return DropdownMenuItem(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Seleccione un rol';
                          }
                          return null;
                        },
                      )
                    ],
                  )),
              const SizedBox(height: 20),
              ShakeButton(
                text: widget.user != null ? 'Editar' : 'Agregar',
                color: primaryVariant,
                isAnimating: false,
                onPressed: () {
                  if (widget.user != null) {
                    controller.updateUser(widget.user.id, {
                      'name': controller.nameController.text,
                      'username': controller.emailController.text,
                      'password': controller.passwordController.text,
                      'area': controller.areaController.text,
                      'role': controller.roleController.text == 'Administrador'
                          ? 1
                          : 2,
                      'editedAt': FieldValue.serverTimestamp()
                    }).whenComplete(
                      () =>
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context),
                    );
                    return;
                  }
                  {
                    if (controller.formKeyUser.currentState!.validate()) {
                      controller.createUser().whenComplete(() {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                    } else {
                      setState(() {});
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
