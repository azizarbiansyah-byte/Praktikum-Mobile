import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Kartunama extends StatelessWidget {
  const Kartunama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Nama Digital',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 215, 215),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/sigma.jpeg'),
                  radius: 90.0,
                ),
                const SizedBox(height: 10),
                Text(
                  'Arbiyan',
                  style: GoogleFonts.alef(
                    fontSize: 30.0,
                    color: const Color.fromARGB(255, 0, 145, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'IF A 24',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20.0,
                    letterSpacing: 3,
                    color: const Color.fromARGB(255, 0, 145, 255),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 150.0,
                  child: Divider(color: Color.fromARGB(228, 0, 0, 0)),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: const Color.fromARGB(255, 0, 145, 255),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text(
                      '+62 831-5355-6666',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: const Color.fromARGB(255, 0, 139, 252),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'azizarbiansyah6@gmail.com',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: const Color.fromARGB(255, 0, 145, 255),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.play_circle),
                    title: Text(
                      'Bianze',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: const Color.fromARGB(255, 0, 145, 255),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.tiktok),
                    title: Text(
                      'Bianze',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}