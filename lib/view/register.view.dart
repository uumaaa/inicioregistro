import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/login.view.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/text.form.global.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controladorMatricula = TextEditingController();
    final TextEditingController controladorContrasena = TextEditingController();
    final TextEditingController controladorNombre = TextEditingController();
    final TextEditingController controladorTipo = TextEditingController();
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return GlobalColors.mainColor;
      }
      return GlobalColors.mainColor;
    }

    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onVerticalDragDown,
      ],
      child: registerPrincipal(controladorMatricula, controladorNombre,
          controladorContrasena, controladorTipo, getColor),
    );
  }

  Scaffold registerPrincipal(
      TextEditingController controladorMatricula,
      TextEditingController controladorNombre,
      TextEditingController controladorContrasena,
      TextEditingController controladorTipo,
      Color getColor(Set<MaterialState> states)) {
    return Scaffold(
      appBar: AppBar(backgroundColor: GlobalColors.mainColor),
      drawer: const SideBarMenuView(),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        'Registro',
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
                controller: controladorNombre,
                textInputType: TextInputType.text,
                textHint: 'Nombre',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              TextFormGlobal(
                controller: controladorContrasena,
                textInputType: TextInputType.text,
                textHint: 'Contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              TextFormGlobal(
                controller: controladorTipo,
                textInputType: TextInputType.text,
                textHint: 'Tipo',
                obscureText: false,
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) => {
                            setState(() {
                              isChecked = value!;
                            })
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Acepto el ',
                        style: TextStyle(
                          color: GlobalColors.colorSombreadoOscuro,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          const url = 'https://linktr.ee/laboratorios.upiit';
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text('reglamento del laboratorio',
                            style: TextStyle(
                              color: GlobalColors.mainColor,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Text(
                        ' y me',
                        style: TextStyle(
                          color: GlobalColors.colorSombreadoOscuro,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 56),
                      Text(
                        'atendo a las consecuencias por\nincumplirlo',
                        style: TextStyle(
                          color: GlobalColors.colorSombreadoOscuro,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
                },
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '¿Ya tienes cuenta?  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.colorSombreadoOscuro),
                ),
                InkWell(
                  onTap: () => Get.to(() => const LoginView()),
                  child: Text('Ingresa',
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }
}
