//Diseño
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicioregistro/extras/database.classes.dart';
import 'package:inicioregistro/utils/global.colors.dart';
import 'package:inicioregistro/view/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
