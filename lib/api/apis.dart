import 'dart:developer';
import 'dart:io';

import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs{
  static late ChatUser me;
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cujrrent user
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for accessing firebase stroage
  static FirebaseStorage storage = FirebaseStorage.instance;
// //to return current user
   //static User get user => auth.currentUser!;
//for checkjing jif user exist or not j?

// // for accessing firebase messaging (push Notification)
//   static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

// // for getting firebase messaging token
// static Future<void> getFirebaseMessaingToken() {
//   await fMessaging.requestPermission();

//   await fMessaging.getToken().then((t)){
//     if(t != null){
//       me.pushToken = t;
//     }
//   }
// } 


  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(appUser.email).get()).exists;
  }
//for getting current user info
static Future<void> getSelfInfo() async{
    await firestore.collection('users').doc(appUser.email).get().then((user) async {
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
       // getFirebaseMessaingToken();
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
//geting aii user
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
  //upload profile picture of user
  static Future<void>updateProfilePicture(File file) async{
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profile_pictures/${appUser.email}.$ext');
    await ref
        .putFile(file,SettableMetadata(contentType: 'image/$ext'))
        .then((po) {
          log('Data Transferred: ${po.bytesTransferred / 1000}kb');
        });

     me.image = await ref.getDownloadURL();

    await firestore.collection('users').doc(appUser.email).update({
      'image':me.image});
  }

  //for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(ChatUser chatUser){
    return firestore.collection('users').where('email', isEqualTo: appUser.email).snapshots();
  }
  //update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async{
    return firestore.collection('users').doc(appUser.email)
    .update({'is_online' : isOnline, 
    'last_active' : DateTime.now().microsecondsSinceEpoch.toString(),
    'push_token' : me.pushToken,
    });
  }

  ///******************  chat Screen Related APIs  ***********************
  

  //useful for getting conversation
  static String getConversationID(String fnd_email) => appUser.email.hashCode <= fnd_email.hashCode 
    ? '${appUser.email}_$fnd_email' 
    : '${fnd_email}_${appUser.email}';

  //for getting all message of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllMessages(ChatUser user){
   // log(ChatUser.fromJson(firestore.collection('users').where('email', isEqualTo: appUser.email).snapshots()));
    return firestore.collection('chats/${getConversationID(user.email)}/messages/').orderBy('sent',descending: true).snapshots();
  }
  //for sending message
  static Future<void> sendMessage(ChatUser user,String msg ,Type type) async{
    //messsage sending time (also used as id)
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    //message to send
    final Message message =  Message(msg: msg, read: "", receiver: user.email, sender: appUser.email, sent: time, type: type);

    final ref=firestore.collection('chats/${getConversationID(user.email)}/messages/');
    await ref.doc().set(message.toJson());
  }

  //update read status jof message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore.collection('chats/${getConversationID(message.sender)}/messages/')
    .doc(message.sent).update({'read':DateTime.now().microsecondsSinceEpoch.toString()});
  }


  //for getting only last message of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String,dynamic>>> getLastMessage(ChatUser user){
   // log(ChatUser.fromJson(firestore.collection('users').where('email', isEqualTo: appUser.email).snapshots()));
    return firestore.collection('chats/${getConversationID(user.email)}/messages/')
    .orderBy('sent',descending: true)
    .limit(1).snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser,File file) async {
    
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('images//${getConversationID(chatUser.email)}/${DateTime.now().microsecondsSinceEpoch}.$ext');
    await ref
        .putFile(file,SettableMetadata(contentType: 'image/$ext'))
        .then((po) {
          log('Data Transferred: ${po.bytesTransferred / 1000}kb');
        });

     final imageUrl = await ref.getDownloadURL();

    await APIs.sendMessage(chatUser, imageUrl, Type.image);
  }


}