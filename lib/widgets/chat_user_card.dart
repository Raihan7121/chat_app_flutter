
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.4,vertical: 4),
      color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: const ListTile(
          //user profile picture
          leading: CircleAvatar(child: Icon(CupertinoIcons.person)),

          //uaer name 
          title: Text('Demo user'),

          //jlast message 
          subtitle: Text('Last User message',maxLines: 1,),

          //last messafge tjime
          trailing: Text('12:12PM',
                      style: TextStyle(color: Colors.black54),),
        ),
      ),
    );
  }
}