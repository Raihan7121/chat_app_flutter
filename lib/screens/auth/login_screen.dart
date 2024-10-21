import 'dart:developer';

import 'package:chat_app/main.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>  _LoginScreenState();
}

class  _LoginScreenState extends State <LoginScreen> {
  bool _isAnimate=false;

  @override
  void initState(){
    
    super.initState();
    Future.delayed(Duration(milliseconds: 500),() {
      setState(() {
        _isAnimate=true;
      });
    });
  }

  _handleGoogleBtnClick(){
    _signInWithGoogle().then( (user ) {

      log('\nUser: ${user.user}');
      log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => const HomeScreen()));
    });

    
  }

  

Future<UserCredential> _signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
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
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25: -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 2),
            child: Image.asset('images/chat_login.png')),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child:ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent.shade100, shape: const StadiumBorder(),elevation: 1),
              onPressed: (){
                _handleGoogleBtnClick();
              },
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
