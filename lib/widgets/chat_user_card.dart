import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/helper/my_date_util.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key,required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  //last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
   
  return Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user,))); 
                // Action when tapped
                //print('Card tapped');
              },
              child: StreamBuilder(
                stream: APIs.getLastMessage(widget.user),
                 builder: (context,snapshot) {

                     if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        final data = snapshot.data?.docs;
                        final list = data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                        if(list.isNotEmpty) _message = list[0];

                        if(data != null && data.first.exists){
                          _message = Message.fromJson(data.first.data());
                        }

                      } else {
                        _message = null; // No message
                      }
                    
                    return ListTile(
               // leading: Icon(Icons.account_circle),
                leading:ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height*.3),
                  child: CachedNetworkImage(
                      height: mq.height * .055,
                      width: mq.height * .055,
                      imageUrl: widget.user.image!,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(child: Icon(CupertinoIcons.person),),
                  ),
                ),

                //user name
                 title: Text(widget.user.name!),

                //last message
                 subtitle: Text(
                 _message != null ? _message!.msg : widget.user.about!,maxLines: 1,),
                //trailing: Icon(Icons.arrow_forward),
                
                //last message time
                trailing: _message == null ? null  :
                        _message!.read.isEmpty && _message!.sender != appUser.email ?
                //show for unread message
                 Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(10)),
                ) :
                //message sent time
                Text(
                  MyDateUtil.getLastMessageTime(context: context, time: _message!.sent),
                  style: TextStyle(color: Colors.black54),
                )
              );
                 })
            ),
          );
}
}