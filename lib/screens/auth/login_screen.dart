import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>  _LoginScreenState();
}

class  _LoginScreenState extends State <LoginScreen> {
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
            left: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('images/chat_login.png')),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child:ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent.shade100, shape: const StadiumBorder(),elevation: 1),
              onPressed: (){},
              icon: Image.asset('images/google.png',height: mq.height * .06,),
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black,fontSize: 16),
                  children: [
                    TextSpan(text: 'signin with '),
                    TextSpan(text: 'google',style: TextStyle(fontWeight: FontWeight.w500))
                  ]
                )),)),
          ],),
    );
  }
}