import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';

class TextFormGlobal extends StatefulWidget {
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
  State<TextFormGlobal> createState() => _TextFormGlobalState();
}

class _TextFormGlobalState extends State<TextFormGlobal> {
  bool isPasswordVisible = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30),
            Text(
              widget.textHint,
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
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: GlobalColors.mainColor,
                    ),
              ),
              child: TextFormField(
                controller: widget.controller,
                cursorColor: GlobalColors.colorSombreado,
                keyboardType: widget.textInputType,
                obscureText: widget.obscureText ? isPasswordVisible : false,
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.colorText,
                ),
                decoration: InputDecoration(
                  suffixIcon: widget.controller.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : widget.obscureText
                          ? IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                                size: 15,
                              ),
                              color: GlobalColors.mainColor,
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                size: 15,
                              ),
                              color: GlobalColors.mainColor,
                              onPressed: () {
                                widget.controller.clear();
                              },
                            ),
                  hintText: widget.textHint,
                  hintStyle: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: GlobalColors.colorSombreado,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
