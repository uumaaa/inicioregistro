import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/extras/database.classes.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/create.booking.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/widgets/drop.down.menu.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final TextEditingController _controllerDate = TextEditingController();
  late String selectedLab;
  late String selectedInHour;
  late String selectedEndHour;
  final int id = 2;
  final int type = 46;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    List<Module> modules;
    List<String> startHours = [];
    List<String> finalHours = [];
    return FutureBuilder(
      future: DatabaseHelper.modules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          modules = snapshot.data ?? [];
          for (var module in modules) {
            startHours.add(module.startHour);
            finalHours.add(module.finalHour);
          }
          return bookingObs(context, currentDate, startHours, finalHours);
        } else {
          return Scaffold(
            backgroundColor: GlobalColors.mainColor,
            body: const Center(
              child: SpinKitChasingDots(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          );
        }
      },
    );
  }

  KeyboardDismisser bookingObs(BuildContext context, DateTime currentDate,
      List<String> startHours, List<String> finalHours) {
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
                            child: const DropdownMenuAlter(
                              listOfItems: ['Laboratorio 1', 'Laboratorio 2'],
                            )),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
                        'Hora de inicio',
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
                            child: DropdownMenuAlter(
                              listOfItems: startHours,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        'Hora de fin',
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
                            child: DropdownMenuAlter(
                              listOfItems: finalHours,
                            )),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Datos de registro',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        'Identificador',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(id.toString())
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        'Ocupacion',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(type.toString()),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
