import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key,required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //remove the back icon
          flexibleSpace: _appBar(),
        ),
      ),
    );
  }
  Widget _appBar(){
    return InkWell(
      onTap: () {},
      child: Row(children: [
        IconButton(onPressed: () => Navigator.pop(context), 
        icon: Icon(Icons.arrow_back,color: Colors.black54,)),
      
        //user profile picture
        ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height*.3),
                    child: CachedNetworkImage(
                        height: mq.height * .05,
                        width: mq.height * .05,
                        imageUrl: widget.user.image!,
                        //placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person),),
                    ),
                  ),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //user name
                Text(widget.user.name!,
                style:const TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w500)),
      
                const SizedBox(height: 2,),
                //last seen time jof user
                Text('Last seen not available',
                style:const TextStyle(fontSize: 13,color: Colors.black54)),
      
              ],)
                  
      ],),
    );
  }
}