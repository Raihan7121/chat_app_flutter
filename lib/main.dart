import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rai chat',
      theme: ThemeData(
       appBarTheme: const AppBarTheme(
         centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 19
            ),
      backgroundColor: Color.fromARGB(255, 50, 17, 216),)),
      
      home: HomeScreen());
  }
}