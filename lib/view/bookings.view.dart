import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/extras/database.classes.dart';
import 'package:inicioregistro/utils/global.colors.dart';

import 'package:inicioregistro/view/register.view.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/widgets/computer.dart';
import 'package:inicioregistro/view/widgets/drop.down.menu.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sqflite/sqflite.dart';

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
    List<Computer> computers;
    return FutureBuilder(
      future:
          Future.wait([DatabaseHelper.modules(), DatabaseHelper.computers()]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          modules = snapshot.data == null ? [] : snapshot.data![0];
          computers = snapshot.data == null ? [] : snapshot.data![1];
          for (var module in modules) {
            startHours.add(module.startHour);
            finalHours.add(module.finalHour);
          }
          return bookingObs(
              context, currentDate, startHours, finalHours, computers);
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

  KeyboardDismisser bookingObs(
      BuildContext context,
      DateTime currentDate,
      List<String> startHours,
      List<String> finalHours,
      List<Computer> computers) {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reservación',
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                                        colorScheme: ThemeData()
                                            .colorScheme
                                            .copyWith(
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
                  height: 10,
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
                  height: 10,
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
                  height: 5,
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
                  height: 40,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 75),
                    itemCount: computers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ComputerInput(
                        computerNumber: computers[index].idComputer + 1,
                        isNotEnabled: false),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    ComputerInputNoFunction(color: 1, text: "Seleccionada(s)"),
                    SizedBox(
                      width: 10,
                    ),
                    ComputerInputNoFunction(color: 2, text: "Disponibles(s)"),
                    SizedBox(
                      width: 10,
                    ),
                    ComputerInputNoFunction(color: 3, text: "Reservada(s)"),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonSized(
                      contenidoBoton: 'Confirmar reservación',
                      function: () => Get.to(() => const RegisterView()),
                      width: 150,
                      height: 35,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
