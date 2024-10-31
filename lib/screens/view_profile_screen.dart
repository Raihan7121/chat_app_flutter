
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/helper/dialogs.dart';
import 'package:chat_app/helper/my_date_util.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import '../widgets/chat_user_card.dart';


class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() =>  _ViewProfileScreenState();
}

class  _ViewProfileScreenState extends State <ViewProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(

          title: Text(widget.user.name!),
          
          ),

          floatingActionButton: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Joined On',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500 ,fontSize: 16),),
                          Text(MyDateUtil.getLastMessageTime(context: context, time: widget.user.createdAt!,showYear: true)!,
                              style: const TextStyle(
                                color: Colors.black54 ,fontSize: 18
                              ),),
                        ],
                      ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.height * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(width: mq.width,height: mq.height* .03,),
                ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height*.1),
                        child: CachedNetworkImage(
                            height: mq.height * .2,
                            width: mq.height * .2,
                            fit: BoxFit.cover,
                            imageUrl: widget.user.image!,
                            // placeholder: (context, url) => CircularProgressIndicator(),
                             errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person),),
                        ),
                      ),
                  
                      SizedBox(height: mq.height* .03,),
                  
                      Text(widget.user.email,style: TextStyle(color: Colors.black87,fontSize: 16),),

                       SizedBox(height: mq.height* .02),
                      
                      //user about 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('About',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500 ,fontSize: 16),),
                          Text(widget.user.about!,
                              style: const TextStyle(
                                color: Colors.black54 ,fontSize: 18
                              ),),
                        ],
                      )
                                      
              ],
            ),
          ),
        ),
    
          ),
    );

  }


}

