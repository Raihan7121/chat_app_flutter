import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs{
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cujrrent user
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // //to return current user
   //static User get user => auth.currentUser!;
//for checkjing jif user exist or not j?
  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(appUser.email).get()).exists;
  }
  //for creating a new user 
  static Future<void> createUser() async{
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      about: 'Hey ,I am using we Chat!', 
      createdAt: time, 
      email: appUser.email.toString(), 
      id: appUser.id, 
      image: appUser.image.toString(), 
      isOnline: false, 
      lastActive: time, 
      name: appUser.name.toString(), 
      pushToken: ' ',
      password: appUser.password.toString());

    return await firestore.collection('users').doc(appUser.email).set(chatUser.toJson());
  }
}