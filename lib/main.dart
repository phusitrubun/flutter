import 'package:flutter/material.dart';
import 'package:flutter_application_1/mainlotto.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansThaiTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF7A0000),
            image: const DecorationImage(
              image: AssetImage('assets/images/wallpaper_lotto3.png'),
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: const Mainlotto(),
        ),
      ),
    );
  }
}
