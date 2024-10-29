import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
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
  @override
  Widget build(BuildContext context) {
   // mq= MediaQuery.of(context).size;
  //   return Card(
  //     margin: EdgeInsets.symmetric(horizontal: mq.width * 0.4,vertical: 4),
  //     //color: Colors.blue.shade100,
  //     elevation: 0.5,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     child: InkWell(
  //       onTap: () {},
  //       child: const ListTile(
  //         //user profile picture
  //         leading: Icon(Icons.person),

  //         //uaer name 
  //         title: Text('Demo user'),

  //         //jlast message 
  //         subtitle: Text('Last User message',maxLines: 1,),

  //         //last messafge tjime
  //         trailing: Text('12:12PM',
  //                     style: TextStyle(color: Colors.black54),), 
  //       ),
  //     ),
  //   );
  // }
  return Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user,))); 
                // Action when tapped
                //print('Card tapped');
              },
              child: ListTile(
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
                 title: Text(widget.user.email),
                 subtitle: Text(widget.user.password,maxLines: 1,),
                //trailing: Icon(Icons.arrow_forward),
                trailing: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          );
}
}