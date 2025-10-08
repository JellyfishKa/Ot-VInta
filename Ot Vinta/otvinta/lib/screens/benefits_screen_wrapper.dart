import 'package:flutter/material.dart';
import 'package:otvinta/screens/benefits_screen.dart';

class BenefitsScreenWrapper extends StatelessWidget {
  const BenefitsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Льготы и программы'),
        centerTitle: true,
      ),
      body: const BenefitsScreen(),
    );
  }
}