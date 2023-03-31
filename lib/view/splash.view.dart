import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Get.to(LoginView()));
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text(
          'Control de Laboratorios',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
