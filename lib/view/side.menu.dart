import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/widgets/info.card.dart';

class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({super.key});

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  String nombre = 'Iker Antonio Pluma Amaro';
  int id = 2022710222;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: 280,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(nombre: nombre, matricula: id),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.time_solid,
                    size: 35,
                    color: Colors.black,
                    semanticLabel: 'Horarios',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Horarios',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.calendar_badge_plus,
                    size: 35,
                    color: Colors.black,
                    semanticLabel: 'Hacer reservación',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Hacer reservación',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.doc_on_clipboard,
                    size: 35,
                    color: Colors.black,
                    semanticLabel: 'Reglamento',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Ver reglamento',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.person_2_square_stack,
                    size: 35,
                    color: Colors.black,
                    semanticLabel: 'Desarrolladores',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Desarrolladores',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 35,
                    color: Colors.black,
                    semanticLabel: 'Iniciar sesión',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Iniciar sesión ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
