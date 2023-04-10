import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerLab = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
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
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Horarios',
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      'Fecha',
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: GlobalColors.mainColor,
                              ),
                        ),
                        child: TextField(
                          cursorColor: GlobalColors.colorSombreado,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(CupertinoIcons.calendar_today),
                            hintText: 'Selecciona una fecha',
                            hintStyle: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: GlobalColors.colorSombreado),
                          ),
                          controller: _controllerDate,
                          onTap: () async {
                            DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: currentDate,
                              lastDate: DateTime(2025),
                              confirmText: 'Aceptar',
                              cancelText: 'Cancelar',
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme:
                                        ThemeData().colorScheme.copyWith(
                                              primary: GlobalColors.mainColor,
                                            ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickdate == null) {
                              return;
                            } else {
                              _controllerDate.text =
                                  '${pickdate.year}-${pickdate.month}-${pickdate.day}';
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Text(
                      'Laboratorio',
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
