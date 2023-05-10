import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/services/remote.services.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/bookings.view.dart';
import 'package:inicioregistro/view/side.menu.dart';
import 'package:inicioregistro/view/widgets/button.global.dart';
import 'package:inicioregistro/view/widgets/drop.down.menu.dart';
import 'package:inicioregistro/view/widgets/reservation.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:inicioregistro/extras/http.database.dart';

class RegisteredBooking extends StatefulWidget {
  const RegisteredBooking({super.key});

  @override
  State<RegisteredBooking> createState() => _RegisteredBookingState();
}

class _RegisteredBookingState extends State<RegisteredBooking> {
  final TextEditingController _controllerDate = TextEditingController();
  late int selectedLab;
  late DateTime now = DateTime.now();
  late DateTime currentDate;
  late DateTime selectedDate;
  late List<Module> modules;
  late List<Reservation> reservations;
  late int user;
  late Future<List<Module>> futureModules;
  late Future<List<Reservation>> reservationsSelected;
  late Future<Map<int, int>> reservationFromMaps;
  late Future<List<Computer>> computersFuture;
  late Map<int, int> count;
  late List<Computer> computers;
  List<String> startHours = [];
  List<String> finalHours = [];
  @override
  void initState() {
    user = 202244;
    selectedLab = 1;
    currentDate = DateTime(now.year, now.month, now.day);
    _controllerDate.text =
        '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    selectedDate = DateTime(now.year, now.month, now.day);
    futureModules = Http().modules();
    reservationsSelected =
        Http().obtainDiferentList(_controllerDate.text, selectedLab);
    reservationFromMaps =
        Http().obtainDiferentReservations(_controllerDate.text, selectedLab);
    computersFuture = Http().computers(selectedLab);
    super.initState();
  }

  void refreshData() {
    setState(() {
      reservationsSelected =
          Http().obtainDiferentList(_controllerDate.text, selectedLab);
      reservationFromMaps =
          Http().obtainDiferentReservations(_controllerDate.text, selectedLab);
      computersFuture = Http().computers(selectedLab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        futureModules,
        reservationsSelected,
        reservationFromMaps,
        computersFuture
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          modules = snapshot.data == null ? [] : snapshot.data![0];
          reservations = snapshot.data == null ? [] : snapshot.data![1];
          count = snapshot.data == null ? [] : snapshot.data![2];
          computers = snapshot.data == null ? [] : snapshot.data![3];
          for (var module in modules) {
            startHours.add(module.startHour);
            finalHours.add(module.finalHour);
          }
          return registeredbookingObs(context, currentDate, startHours,
              finalHours, reservations, count, computers);
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

  KeyboardDismisser registeredbookingObs(
      BuildContext context,
      DateTime currentDate,
      List<String> startHours,
      List<String> finalHours,
      List<Reservation> reservations,
      Map<int, int> count,
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
                              readOnly: true,
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
                                returnValue: (p0) {
                                  selectedLab = p0;
                                },
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 450,
                  margin: const EdgeInsets.all(15),
                  child: reservations.isNotEmpty
                      ? ListView.builder(
                          itemCount: reservations.length,
                          prototypeItem: ReservationView(
                              seats: 1,
                              type: reservations.first.reservationType,
                              startHour: '',
                              finalHour: '',
                              number: reservations.first.idReservation),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ReservationView(
                              seats: (computers.length - (count[index] ?? 0)),
                              type: reservations[index].reservationType,
                              startHour:
                                  startHours[(reservations[index].idModuloS)],
                              finalHour:
                                  finalHours[(reservations[index].idModuloE)],
                              number: index + 1))
                      : Container(child: Text("No hay reservaciones")),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonSized(
                      isEnable: true,
                      contenidoBoton: 'Hacer reservación',
                      function: () => Get.to(() => const BookingView()),
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
