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
      required this.lab});
  final int type;
  final String startHour;
  final String finalHour;
  final int lab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Laboratorio',
                style: TextStyle(
                  fontSize: 24,
                  color: GlobalColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                lab.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                width: 120,
              ),
              Icon(
                CupertinoIcons.calendar_circle_fill,
                size: 40,
                color: type == 1 ? Colors.blue : Colors.red,
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Hora de inicio',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    startHour,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
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
                  Text(
                    finalHour,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
