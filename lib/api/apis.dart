import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs{
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cujrrent user
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //to return current user
  static User get user => auth.currentUser!;

//for checkjing jif user exist or not j?
  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }
  //for creating a new user 
  static Future<void> createUser() async{
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      about: 'Hey ,I am using we Chat!', 
      createdAt: time, 
      email: user.email.toString(), 
      id: user.uid, 
      image: user.photoURL.toString(), 
      isOnline: false, 
      lastActive: time, 
      name: user.displayName.toString(), 
      pushToken: ' ');

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }
}