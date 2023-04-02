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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: GlobalColors.colorFondo,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: GlobalColors.mainColor,
        keyboardType: textInputType,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1,
          fontWeight: FontWeight.bold,
          color: GlobalColors.mainColor,
        ),
        decoration: InputDecoration(
            hintText: textHint,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: GlobalColors.mainColor, width: 2.5),
                borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: GlobalColors.mainColor, width: 2.5),
                borderRadius: BorderRadius.circular(50)),
            contentPadding: const EdgeInsets.all(0),
            hintStyle: TextStyle(
              height: 1,
              fontWeight: FontWeight.bold,
              color: GlobalColors.mainColor,
            )),
      ),
    );
  }
}
