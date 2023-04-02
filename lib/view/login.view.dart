import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/extras/database.classes.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/widgets/text.form.global.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/register.view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controladorMatricula = TextEditingController();
    final TextEditingController controladorContrasena = TextEditingController();
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
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo_ipn.webp',
                  height: 150,
                ),
              ),
              const SizedBox(height: 115),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inicia sesión',
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
                controller: controladorContrasena,
                textInputType: TextInputType.text,
                textHint: 'Contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ActionButton(
                contenidoBoton: 'Iniciar sesión',
                function: () async {
                  final matricula = controladorMatricula.value.text;
                  final contrasena = controladorContrasena.value.text;
                  if (matricula.isEmpty || contrasena.isEmpty) {
                    return;
                  }

                  final posibleUser = await DatabaseHelper.getUser(
                      int.parse(matricula), contrasena);
                  if (posibleUser.id == -1) {
                    print('Usuario y/o contraseña incorrecto');
                    return;
                  }
                  print('Inicio de sesión correcto');
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
          const Text('¿No tienes cuenta?    '),
          InkWell(
            onTap: () => Get.to(() => const RegisterView()),
            child: Text('Regístrate',
                style: TextStyle(color: GlobalColors.mainColor)),
          )
        ]),
      ),
    );
  }
}
