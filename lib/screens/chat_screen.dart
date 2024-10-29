import 'package:chat_app/models/chat_user.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //remove the back icon
        flexibleSpace: _appBar(),
      ),
    );
  }
  Widget _appBar(){
    return Row(children: [
      IconButton(onPressed: () {}, 
      icon: Icon(Icons.arrow_back,color: Colors.black54,))
    ],);
  }
}