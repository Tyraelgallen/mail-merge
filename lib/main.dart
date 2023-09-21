import 'package:flutter/material.dart';
import 'package:mail_merge/screens/comandos.dart';
import 'package:mail_merge/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Home",
      routes: {
        "Home": (context) => Home(),
      },
    );
  }
}

//comando para generar web (archivo HTML,JS,etc):
//flutter build web
