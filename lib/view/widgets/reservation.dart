import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/global.colors.dart';

class ReservationView extends StatelessWidget {
  const ReservationView(
      {super.key,
      required this.type,
      required this.startHour,
      required this.finalHour,
      required this.number,
      required this.seats});
  final int type;
  final String startHour;
  final String finalHour;
  final int number;
  final int seats;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: type == 1
                      ? const Color.fromARGB(152, 1, 101, 251)
                      : GlobalColors.mainColor,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: type == 1
                ? const Color.fromARGB(255, 1, 100, 251)
                : GlobalColors.mainColor),
        margin: const EdgeInsets.fromLTRB(4, 10, 4, 0),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 230,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reservacion $number",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            startHour,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40),
                          ),
                          const Icon(
                            CupertinoIcons.arrow_right_circle_fill,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            finalHour,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: 60,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    CupertinoIcons.calendar_badge_plus,
                    size: 50,
                    color: Colors.white,
                  ),
                  type == 2
                      ? const Text(
                          'Reservada',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          '${30 - seats} asiento(s) libre(s)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                ],
              ),
            ),
          ],
        ));
  }
}
