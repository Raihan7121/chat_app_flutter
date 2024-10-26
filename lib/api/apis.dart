import 'dart:developer';

import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs{
  static late ChatUser me;
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

static Future<void> getSelfInfo() async{
    await firestore.collection('users').doc(appUser.email).get().then((user) async {
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
      }else {
        await createUser().then((value) => getSelfInfo());
      }
    });
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

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllUsers(){
   // log(ChatUser.fromJson(firestore.collection('users').where('email', isEqualTo: appUser.email).snapshots()));
    return firestore.collection('users').where('email', isNotEqualTo: appUser.email).snapshots();
  }
//for updste user information
 static Future<void> updateUserInfo() async{
    await firestore.collection('users').doc(appUser.email).update({
      'name':me.name,
      'about': me.about});
  }


}