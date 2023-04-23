import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/view/bookings.view.dart';
import 'package:inicioregistro/view/login.view.dart';
import 'package:inicioregistro/view/register.view.dart';
import 'package:inicioregistro/view/widgets/info.card.dart';
import 'package:inicioregistro/view/widgets/registered.booking.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBarMenuView extends StatefulWidget {
  const SideBarMenuView({super.key});

  @override
  State<SideBarMenuView> createState() => _SideBarMenuViewState();
}

class _SideBarMenuViewState extends State<SideBarMenuView> {
  String nombre = 'Iker Antonio Pluma Amaro';
  int id = 2022710222;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: [
          Container(
            width: 300,
            height: double.infinity,
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: [
                  InfoCard(nombre: nombre, matricula: id),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          CupertinoIcons.time_solid,
                          size: 35,
                          color: Colors.black,
                          semanticLabel: 'Horarios',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Horarios',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () => Get.to(() => const RegisteredBooking()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          CupertinoIcons.calendar_badge_plus,
                          size: 35,
                          color: Colors.black,
                          semanticLabel: 'Hacer reservación',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Hacer reservación',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () => Get.to(() => const BookingView()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          CupertinoIcons.doc_on_clipboard,
                          size: 35,
                          color: Colors.black,
                          semanticLabel: 'Reglamento',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Ver reglamento',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () async {
                      const url = 'https://linktr.ee/laboratorios.upiit';
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          CupertinoIcons.person_2_square_stack,
                          size: 35,
                          color: Colors.black,
                          semanticLabel: 'Desarrolladores',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Desarrolladores',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () async {},
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          CupertinoIcons.person_crop_circle,
                          size: 35,
                          color: Colors.black,
                          semanticLabel: 'Iniciar sesión',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Iniciar sesión ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () => Get.to(() => const LoginView()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
