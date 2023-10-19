import 'package:flutter/material.dart';

import '../screen/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5986EC)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MenuScreen(),
    );
  }
}
