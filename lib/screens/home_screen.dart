import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/api/apis.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import '../widgets/chat_user_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>  _HomeScreenState();
}

class  _HomeScreenState extends State <HomeScreen> {

 List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const Icon(CupertinoIcons.home),
        title: const Text('rai chat'),
        actions: [
          //search user button
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          //more features button
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: list[0])));
          }, icon: const Icon(Icons.more_vert)),
        ],
        
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(onPressed: () async {
            await APIs.auth.signOut(); 
           // await GoogleSignIn().signOut();
          },child: const Icon(Icons.add_comment_rounded),),
        ),
        body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context ,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const AlertDialog(
              content: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return AlertDialog(
              content: Text('Error: ${snapshot.error}'),
            );
          }

            // Switch(snapshot.connectionState){

            //   case ConnectionState.waiting:
            //   case ConnectionState.none:
            //     return const Center(child: CircularProgressIndicator());

            //   case ConnectionState.active:
            //   case ConnectionState.done:


            // }

            // final list = [];

            if(snapshot.hasData){
              final data = snapshot.data?.docs;

              list = 
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              // for(var i in data!){
              //   log('Data: ${jsonEncode(i.data())}');
              //   list.add(i.data()['name']);
              // }
            }
            if(list.isNotEmpty){
                return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: mq.height * .01),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatUserCard(user: list[index]);
                 // return Text('name: salasaowa');
                });
            }else{
              return const Center(
                child: Text('No Connections Found!',
                        style: TextStyle(fontSize: 20),)
              );
            }
            
          }
        ),
    );
  }
}