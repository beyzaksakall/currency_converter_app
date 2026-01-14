import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const DovizmatikApp());
}

class DovizmatikApp extends StatelessWidget {
  const DovizmatikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
