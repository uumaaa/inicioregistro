import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.nombre, required this.matricula});
  final String nombre;
  final int matricula;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: GlobalColors.colorText,
        child: const Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        nombre,
        style: TextStyle(
          color: GlobalColors.colorText,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(matricula.toString(),
          style: TextStyle(
            color: GlobalColors.colorSombreadoOscuro,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}
