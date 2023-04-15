import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../utils/global.colors.dart';

class CreateBooking extends StatefulWidget {
  const CreateBooking({super.key});

  @override
  State<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking> {
  final TextEditingController _controllerDate = TextEditingController();
  String? selectedItemMenu = 'Laboratorio 1';
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
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: GlobalColors.mainColor,
                              ),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: TextField(
                            textAlign: TextAlign.center,
                            cursorColor: GlobalColors.colorSombreado,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                CupertinoIcons.calendar_today,
                                size: 15,
                              ),
                              hintText: 'Selecciona una fecha',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: GlobalColors.colorSombreado),
                            ),
                            controller: _controllerDate,
                            onTap: () async {
                              DateTime? pickdate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: DateTime(currentDate.year,
                                    currentDate.month, currentDate.day - 14),
                                lastDate: DateTime(currentDate.year,
                                    currentDate.month, currentDate.day + 14),
                                confirmText: 'Aceptar',
                                cancelText: 'Cancelar',
                                helpText: 'Selecciona una fecha',
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
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                                  primary: GlobalColors.mainColor,
                                ),
                          ),
                          child: DropdownButtonFormField(
                            items: const [
                              DropdownMenuItem(
                                value: 'Laboratorio 1',
                                child: Center(
                                  child: Text(
                                    'Laboratorio 1',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'Laboratorio 2',
                                child: Center(
                                  child: Text(
                                    'Laboratorio 2',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                            value: selectedItemMenu,
                            onChanged: (item) => setState(
                              () {
                                selectedItemMenu = item;
                              },
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            iconEnabledColor: GlobalColors.mainColor,
                            isExpanded: true,
                          ),
                        ),
                      )
                    ],
                  ),
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
                        'No. de boleta',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButtonSized(
                    contenidoBoton: 'Hacer reservación',
                    function: () => Get.to(() => const CreateBooking()),
                    width: 130,
                    height: 35,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
