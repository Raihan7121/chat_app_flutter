import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/api/apis.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import '../widgets/chat_user_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>  _HomeScreenState();
}

class  _HomeScreenState extends State <HomeScreen> {

 List<ChatUser> _list = [];
 final List<ChatUser> _searchList = [];
 bool _isSearching =false;

@override
 void initState(){
  super.initState();
  APIs.getSelfInfo();
  APIs.updateActiveStatus(true);
  SystemChannels.lifecycle.setMessageHandler((message){
    if(appUser != null){
      if(message.toString().contains('resume'))APIs.updateActiveStatus(true);
      if(message.toString().contains('pause'))APIs.updateActiveStatus(false);
    } 
    return Future.value(message);
  });
 }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_isSearching){
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          }else{
            return Future.value(true);
          }
          
        },
        child: Scaffold(
          appBar: AppBar(
            leading:const Icon(CupertinoIcons.home),
            title: _isSearching ?TextField(
              decoration: InputDecoration(border: InputBorder.none,hintText: 'name email.....'),
              autofocus: true,
              style: TextStyle(fontSize: 17,letterSpacing: .5),
              onChanged: (val){
                _searchList.clear();
                for(var i in _list){
                  if(i.name!.toLowerCase().contains(val.toLowerCase()) ||
                    i.name!.toLowerCase().contains(val.toLowerCase())){
                      _searchList.add(i);
                    }
                    setState(() {
                      _searchList;
                    });
                }
              },
            ): Text('rai chat'),
            actions: [
              //search user button
              IconButton(onPressed: (){
                setState(() {
                  _isSearching = !_isSearching;
                });
              }, icon: Icon(_isSearching?CupertinoIcons.clear_circled_solid:Icons.search)),
              //more features button
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: APIs.me)));
          },
            icon: const Icon(Icons.more_vert)),
        
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
              stream: APIs.getAllUsers(),
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
        
                  _list =data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                
                }
                if(_list.isNotEmpty){
                    return ListView.builder(
                    itemCount: _isSearching ? _searchList.length : _list.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUserCard(user: _isSearching? _searchList[index] : _list[index]);
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
        ),
      ),
    );
  }
}