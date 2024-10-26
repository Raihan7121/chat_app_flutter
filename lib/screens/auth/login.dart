import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // void _signIn() {
  //   if (_formKey.currentState!.validate()) {
  //     // Perform login action (e.g., call authentication API)
  //     final email = _emailController.text;
  //     final password = _passwordController.text;

  //     // For now, just display the entered values
  //     print('Email: $email');
  //     print('Password: $password');

  //     // Add your actual login logic here
  //   }
  // }
  void _in(){
     FirebaseFirestore db = FirebaseFirestore.instance;

     String email=_emailController.text;
     String password=_passwordController.text;

      final time = DateTime.now().microsecondsSinceEpoch.toString();

      final userAcc = ChatUser(email: email, password: password);
    
      // appUser.about='Hey ,I am using we Chat!'; 
      // appUser.createdAt= time; 
      // appUser.email= appUser.email.toString(); 
      // //id: appUser.uid, 
      // //image: appUser.photoURL.toString(), 
      // appUser.isOnline= false; 
      // appUser.lastActive= time; 
      // appUser.name= "rai";
      // appUser.pushToken= ' ';
      // appUser.password= ' ';

    

      final city = <String, String>{
  "name": "Los Angeles",
  "state": "CA",
  "country": "USA"
};

db
    .collection("users")
    .doc(email)
    .set(userAcc.toJson())
    .onError((e, _) => print("Error writing document: $e"));
  }

  // void _signIn() async {

    
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Get the email and password from the form fields
  //       final email = _emailController.text;
  //       final password = _passwordController.text;

  //       // Sign in the user with Firebase Authentication
  //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       // Store additional user information in Firestore (optional)
  //       await _firestore.collection('users').doc(userCredential.user!.uid).set({
  //         'email': email,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });

  //       // Display success message or navigate to a different screen
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Successfully registered')),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       // Handle Firebase authentication errors
  //       String message;
  //       if (e.code == 'email-already-in-use') {
  //         message = 'The email is already in use by another account.';
  //       } else if (e.code == 'weak-password') {
  //         message = 'The password is too weak.';
  //       } else {
  //         message = e.message!;
  //       }

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(message)),
  //       );
  //     }
  //   }
  // }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Check for a valid email format
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _in,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
