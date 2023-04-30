import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inicioregistro/extras/database.classes.dart';
import 'package:inicioregistro/utils/global.colors.dart';

import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/widgets/computer.dart';
import 'package:inicioregistro/view/widgets/drop.down.menu.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final TextEditingController _controllerDate = TextEditingController();
  late int selectedLab;
  late int selectedInHour;
  late int selectedEndHour;
  final int id = 2;
  final int type = 46;
  DateTime now = DateTime.now();
  late DateTime currentDate;
  late DateTime selectedDate;
  late Future<List<List<dynamic>>> futureComputers;
  late Future futureModulesComputers;
  late bool allComputers;
  late List<int> selectedComputers;
  @override
  void initState() {
    currentDate = DateTime(now.year, now.month, now.day);
    allComputers = false;
    selectedLab = 1;
    selectedEndHour = 1;
    selectedInHour = 1;
    selectedComputers = [];
    _controllerDate.text =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    selectedDate = DateTime(now.year, now.month, now.day);
    futureModulesComputers = DatabaseHelper.modules();
    futureComputers = Future.wait(
      [
        DatabaseHelper.getComputersBetweenModules(
            selectedInHour, selectedEndHour, _controllerDate.text, selectedLab),
        DatabaseHelper.computers(selectedLab),
      ],
    );
    super.initState();
  }

  void refreshData() {
    setState(() {
      selectedComputers = [];
      futureComputers = Future.wait(
        [
          DatabaseHelper.getComputersBetweenModules(selectedInHour,
              selectedEndHour, _controllerDate.text, selectedLab),
          DatabaseHelper.computers(selectedLab),
        ],
      );
      var splitDate = _controllerDate.text.split("-");
      selectedDate = DateTime(int.parse(splitDate[0]), int.parse(splitDate[1]),
          int.parse(splitDate[2]));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Module> modules;
    List<String> startHours = [];
    List<String> finalHours = [];

    return FutureBuilder(
      future: futureModulesComputers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          modules = snapshot.data == null ? [] : snapshot.data!;
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
                                      currentDate.month, currentDate.day),
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
                                  refreshData();
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
                            child: DropdownMenuAlter(
                              listOfItems: const [
                                'Laboratorio 1',
                                'Laboratorio 2'
                              ],
                              selectedItem: selectedLab,
                              refreshData: refreshData,
                              returnValue: ((p0) {
                                selectedLab = p0;
                              }),
                            ),
                          ),
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
                              selectedItem: selectedInHour,
                              listOfItems: startHours,
                              refreshData: refreshData,
                              returnValue: ((p0) {
                                selectedInHour = p0;
                              }),
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
                              selectedItem: selectedEndHour,
                              refreshData: refreshData,
                              returnValue: ((p0) {
                                selectedEndHour = p0;
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                  future: futureComputers,
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      List<Computer> computers = snapshot.data![1];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 8,
                                      childAspectRatio: 1.3,
                                      crossAxisSpacing: 5,
                                      mainAxisExtent: 75),
                              itemCount: computers.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ComputerInput(
                                  selectedReturnValue: (p0) {
                                    if (selectedComputers.contains(p0)) {
                                      selectedComputers.remove(p0);
                                    } else {
                                      selectedComputers.add(p0);
                                    }
                                  },
                                  computerNumber:
                                      computers[index].idComputer + 1,
                                  isNotEnabled: snapshot.data![0]
                                      .contains(computers[index])),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox(
                        child: Text('No hay información'),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                        value: allComputers,
                        onChanged: (item) {
                          setState(() {
                            allComputers = item!;
                          });
                          refreshData();
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    const ComputerInputNoFunction(
                        color: 1, text: "Seleccionada(s)"),
                    const SizedBox(
                      width: 10,
                    ),
                    const ComputerInputNoFunction(
                        color: 2, text: "Disponibles(s)"),
                    const SizedBox(
                      width: 10,
                    ),
                    const ComputerInputNoFunction(
                        color: 3, text: "Reservada(s)"),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonSized(
                      isEnable: !(selectedDate.isBefore(currentDate) ||
                          selectedDate.isAtSameMomentAs(now)),
                      contenidoBoton: 'Confirmar reservación',
                      function: () {
                        print(selectedComputers);
                      },
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
