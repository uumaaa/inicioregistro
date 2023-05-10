import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/services/remote.services.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/registered.booking.view.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/widgets/computer.dart';
import 'package:inicioregistro/view/widgets/drop.down.menu.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:inicioregistro/extras/http.database.dart';

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
  late List<Computer> computers;
  late List<Computer> disabledComputers;
  late int firstEndModuleIndex;
  late int user;
  @override
  void initState() {
    user = 202244;
    currentDate = DateTime(now.year, now.month, now.day);
    allComputers = false;
    selectedLab = 1;
    disabledComputers = [];
    selectedEndHour = 1;
    selectedInHour = 1;
    firstEndModuleIndex = 0;
    selectedComputers = [];
    computers = [];
    _controllerDate.text =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    selectedDate = DateTime(now.year, now.month, now.day);
    futureModulesComputers = Http().modules();
    futureComputers = Future.wait(
      [
        Http().getComputersBetweenModules(
            selectedInHour, selectedEndHour, _controllerDate.text, selectedLab),
        Http().computers(selectedLab),
      ],
    );
    super.initState();
  }

  void refreshData() {
    setState(() {
      selectedComputers = [];
      allComputers = false;
      firstEndModuleIndex = selectedInHour - 1;
      if (selectedInHour > selectedEndHour) {
        selectedEndHour = selectedInHour;
      }
      futureComputers = Future.wait(
        [
          Http().getComputersBetweenModules(selectedInHour, selectedEndHour,
              _controllerDate.text, selectedLab),
          Http().computers(selectedLab),
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
                              keyboardType: TextInputType.none,
                              readOnly: true,
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
                              firstIndex: 0,
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
                              firstIndex: 0,
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
                              key: UniqueKey(),
                              listOfItems: finalHours,
                              selectedItem: selectedEndHour,
                              firstIndex: firstEndModuleIndex,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selecciona tu computadora',
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                FutureBuilder(
                  future: futureComputers,
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      computers = snapshot.data![1];
                      disabledComputers = snapshot.data![0];
                      if (computers.length == disabledComputers.length) {
                        selectedComputers.clear();
                        allComputers = false;
                      }
                      if (allComputers) {
                        for (var computer in computers) {
                          if (!disabledComputers.contains(computer) &&
                              !selectedComputers
                                  .contains(computer.idComputer)) {
                            selectedComputers.add(computer.idComputer);
                          }
                          if (disabledComputers.contains(computer)) {
                            selectedComputers.remove(computer.idComputer);
                          }
                        }
                      }
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                key: UniqueKey(),
                                initState: selectedComputers
                                    .contains(computers[index].idComputer),
                                selectedReturnValue: (p0) {
                                  if (selectedComputers.contains(p0 - 1)) {
                                    selectedComputers.remove(p0 - 1);
                                    setState(() {
                                      if (allComputers) {
                                        allComputers = !allComputers;
                                      }
                                    });
                                  } else {
                                    selectedComputers.add(p0 - 1);
                                    setState(() {
                                      if (selectedComputers.length ==
                                          (computers.length -
                                              disabledComputers.length)) {
                                        allComputers = true;
                                      }
                                    });
                                  }
                                },
                                computerNumber: computers[index].idComputer + 1,
                                isNotEnabled: disabledComputers
                                    .contains(computers[index]))),
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
                    Container(
                      width: 15,
                      height: 15,
                      child: Checkbox(
                        value: allComputers,
                        onChanged: (item) {
                          setState(
                            () {
                              if (!(computers.length ==
                                  disabledComputers.length)) {
                                selectedComputers.clear();
                                allComputers = item!;
                              }
                              if (allComputers) {
                                for (var computer in computers) {
                                  if (!disabledComputers.contains(computer) &&
                                      !selectedComputers
                                          .contains(computer.idComputer)) {
                                    selectedComputers.add(computer.idComputer);
                                  }
                                  if (disabledComputers.contains(computer)) {
                                    selectedComputers
                                        .remove(computer.idComputer);
                                  }
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Seleccionar todas',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButtonSized(
                        contenidoBoton: 'Regresar',
                        function: () => Get.to(() => const RegisteredBooking()),
                        width: 150,
                        height: 35,
                        fontSize: 12,
                        isEnable: true),
                    ActionButtonSized(
                      key: UniqueKey(),
                      isEnable: selectedComputers.isNotEmpty,
                      contenidoBoton: 'Confirmar reservación',
                      function: selectedComputers.isNotEmpty
                          ? () async {
                              if (_controllerDate.text.isEmpty ||
                                  selectedEndHour.isNaN ||
                                  selectedInHour.isNaN ||
                                  selectedLab.isNaN ||
                                  selectedComputers.isEmpty) {
                                return;
                              }
                              int numberOfReservations =
                                  await Http().numberOfReservations();
                              int cont = numberOfReservations + 1;
                              for (int specificComputer in selectedComputers) {
                                Reservation reservation = Reservation(
                                    idReservation: cont,
                                    idUsuario: user,
                                    idModuloS: selectedInHour,
                                    idModuloE: selectedEndHour,
                                    idLab: selectedLab,
                                    reservationType: allComputers ? 2 : 1,
                                    reservationDate: _controllerDate.text,
                                    idComputer: specificComputer);
                                await Http().insertReservation(reservation);
                                cont++;
                              }
                              Get.to(() => const RegisteredBooking());
                            }
                          : () {},
                      width: 150,
                      height: 35,
                      fontSize: 12,
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
