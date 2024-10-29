
import 'package:chat_app/models/chat_user.dart';
//import 'package:chat_app/screens/auth/login.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//global jobject size
late Size mq;
late ChatUser appUser;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
  .then((value) {
        _initializeFirebase();
        runApp(const MyApp());
  });
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rai chat',
      debugShowCheckedModeBanner: false,
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
      
      home: LoginScreen());
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}