import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal(
      {super.key,
      required this.controller,
      required this.textHint,
      required this.textInputType,
      required this.obscureText});
  final TextEditingController controller;
  final String textHint;
  final TextInputType textInputType;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            Text(
              textHint,
              style: TextStyle(
                  fontSize: 14,
                  height: 1,
                  color: GlobalColors.mainColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Center(
          child: Container(
            width: 300,
            height: 35,
            decoration: BoxDecoration(
              color: GlobalColors.colorFondo,
            ),
            child: TextFormField(
              controller: controller,
              cursorColor: GlobalColors.colorFondo,
              keyboardType: textInputType,
              obscureText: obscureText,
              textAlign: TextAlign.start,
              style: TextStyle(
                height: 1,
                fontWeight: FontWeight.bold,
                color: GlobalColors.colorText,
              ),
              decoration: InputDecoration(
                  hintText: textHint,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: GlobalColors.colorSombreado, width: 1.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: GlobalColors.colorSombreado, width: 1.5)),
                  hintStyle: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: GlobalColors.colorSombreado,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
