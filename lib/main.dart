import 'package:enterprise_ui_playground/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enterpsise UI Playground',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 22, 8, 222))),
      home: const AppRouter(),
    );
  }
}