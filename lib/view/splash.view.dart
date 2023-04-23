import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/bookings.view.dart';
import 'package:inicioregistro/view/widgets/registered.booking.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),
        () => Get.to(() => const RegisteredBooking()));
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo_ipn_white.png',
          height: 350,
        ),
      ),
    );
  }
}
