import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/login.view.dart';
import 'package:inicioregistro/view/widgets/text.form.global.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import '../extras/database.classes.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controladorMatricula = TextEditingController();
    final TextEditingController controladorContrasena = TextEditingController();
    final TextEditingController controladorNombre = TextEditingController();
    final TextEditingController controladorTipo = TextEditingController();
    return Scaffold(
      backgroundColor: GlobalColors.colorFondo,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo_ipn.webp',
                  height: 150,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registrate',
                    style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormGlobal(
                controller: controladorMatricula,
                textInputType: TextInputType.number,
                textHint: 'Matrícula',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: controladorNombre,
                textInputType: TextInputType.text,
                textHint: 'Nombre',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: controladorContrasena,
                textInputType: TextInputType.text,
                textHint: 'Contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: controladorTipo,
                textInputType: TextInputType.text,
                textHint: 'Tipo',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              ActionButton(
                contenidoBoton: 'Registrate',
                function: () async {
                  final matricula = controladorMatricula.value.text;
                  final contrasena = controladorContrasena.value.text;
                  final nombre = controladorNombre.value.text;
                  final tipo = controladorTipo.value.text;
                  if (matricula.isEmpty ||
                      contrasena.isEmpty ||
                      nombre.isEmpty ||
                      tipo.isEmpty) {
                    return;
                  }
                  final user = User(
                      id: int.parse(matricula),
                      name: nombre,
                      password: contrasena,
                      type: int.parse(tipo));
                  await DatabaseHelper.insertUser(user);
                },
              ),
              const SizedBox(height: 10),
              ActionButton(
                  contenidoBoton: 'mostrar base de datos',
                  function: () async {
                    print(await DatabaseHelper.users());
                  }),
            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
        height: 50,
        color: GlobalColors.colorFondo,
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('¿Ya tienes cuenta?    '),
          InkWell(
            onTap: () => Get.to(() => const LoginView()),
            child: Text('Inicia sesión',
                style: TextStyle(color: GlobalColors.mainColor)),
          )
        ]),
      ),
    );
  }
}
