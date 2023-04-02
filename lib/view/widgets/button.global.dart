import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, required this.contenidoBoton, required this.function});
  final String contenidoBoton;
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ],
        ),
        child: Text(contenidoBoton,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
