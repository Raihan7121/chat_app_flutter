import 'package:chat_app/main.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
// import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>  _SplashScreenState();
}

class  _SplashScreenState extends State <SplashScreen> {
  
  @override
  void initState(){
      super.initState();
      Future.delayed(const Duration(microseconds: 2000), (){
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      });
  }
  @override 
  Widget build(BuildContext context) {
    mq= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Wellcome to rai chat'),  
        ),
        
        body: Stack(children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25 ,
            width: mq.width * .5,
        
            child: Image.asset('images/chat_login.png')),

            //google login button
          Positioned(
            bottom: mq.height * .15,
            width: mq.width ,
        
            child: const Text('Made in BD',
            textAlign: TextAlign.center,
             style: TextStyle(fontSize: 16, color: Colors.black87 ,letterSpacing: .5),)),
          ],),
    );
  }
}