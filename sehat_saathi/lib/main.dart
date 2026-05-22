import 'package:flutter/material.dart';
import 'package:sehat_saathi/screens/city_screen.dart';
import 'package:sehat_saathi/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehat Saathi',
      theme: AppTheme.lightTheme,
      home: const CityScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}