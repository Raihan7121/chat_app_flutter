import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                // Action when tapped
                print('Card tapped');
              },
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(widget.user.name),
                subtitle: Text(widget.user.about,maxLines: 1,),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
}
}