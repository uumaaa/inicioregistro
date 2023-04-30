import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, required this.contenidoBoton, required this.function});
  final String contenidoBoton;
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: function,
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 300,
            decoration: BoxDecoration(
              color: GlobalColors.mainColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: GlobalColors.mainColor.withOpacity(0.34),
                    blurRadius: 10)
              ],
            ),
            child: Text(contenidoBoton,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    );
  }
}

class ActionButtonSized extends StatelessWidget {
  const ActionButtonSized(
      {super.key,
      required this.contenidoBoton,
      required this.function,
      required this.width,
      required this.height,
      required this.fontSize,
      required this.isEnable});
  final String contenidoBoton;
  final void Function() function;
  final double width;
  final double height;
  final double fontSize;
  final bool isEnable;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: function,
          child: Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: isEnable
                  ? GlobalColors.mainColor
                  : const Color.fromARGB(255, 204, 204, 204),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: GlobalColors.mainColor.withOpacity(0.34),
                    blurRadius: 0)
              ],
            ),
            child: Text(contenidoBoton,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                )),
          ),
        ),
      ],
    );
  }
}
