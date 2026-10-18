import 'package:flutter/material.dart';
import 'package:tugas_3/kalkulatorScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const KalkulatorBMI());
}

class KalkulatorBMI extends StatelessWidget {
  const KalkulatorBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator BMI ',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.fredokaTextTheme(),
        ),
      home: KalkulatorBMIScreen(),
    );
  }
}
