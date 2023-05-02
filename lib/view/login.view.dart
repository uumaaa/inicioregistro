import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/services/remote.services.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/text.form.global.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/register.view.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controladorMatricula = TextEditingController();
    final TextEditingController controladorContrasena = TextEditingController();
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onVerticalDragDown,
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
        ),
        drawer: const SideBarMenuView(),
        backgroundColor: GlobalColors.colorFondo,
        body: loginPrincipal(controladorMatricula, controladorContrasena),
        bottomNavigationBar: Container(
          height: 50,
          color: GlobalColors.colorFondo,
          alignment: Alignment.topRight,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              onTap: () => Get.to(() => const RegisterView()),
              child: Text('Crea una cuenta',
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              width: 50,
            ),
          ]),
        ),
      ),
    );
  }

  SingleChildScrollView loginPrincipal(
      TextEditingController controladorMatricula,
      TextEditingController controladorContrasena) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo_ipn_red.webp',
                height: 150,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      'Inicio de sesión',
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextFormGlobal(
              controller: controladorMatricula,
              textInputType: TextInputType.number,
              textHint: 'Matrícula',
              obscureText: false,
            ),
            const SizedBox(height: 15),
            TextFormGlobal(
              controller: controladorContrasena,
              textInputType: TextInputType.text,
              textHint: 'Contraseña',
              obscureText: true,
            ),
            const SizedBox(height: 50),
            ActionButton(
              contenidoBoton: 'Iniciar sesión',
              function: () async {
                final matricula = controladorMatricula.value.text;
                final contrasena = controladorContrasena.value.text;
                if (matricula.isEmpty || contrasena.isEmpty) {
                  return;
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
