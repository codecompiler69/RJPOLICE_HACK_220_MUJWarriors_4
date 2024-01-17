import 'package:fir_analysis/fir_new.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR App',
      home: FIRForm(ipcSections:'' , description: '',),
    );
  }
}
