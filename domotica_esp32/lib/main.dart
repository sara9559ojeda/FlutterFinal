import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/home_binding.dart';
import 'app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Domótica ESP32',
      initialBinding: HomeBinding(),
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
