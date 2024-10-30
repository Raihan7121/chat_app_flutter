import 'package:chat_app/api/apis.dart';
import 'package:chat_app/helper/my_date_util.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return appUser.email == widget.message.sender ? _greenMessage() : _blueMessage() ;
  }

  // sender or another user massage
  Widget _blueMessage(){
    //update last read message if sender and receiver are different
    if(widget.message.read.isEmpty){
      APIs.updateMessageReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(horizontal: mq.width *.04,vertical: mq.height * .01),
            decoration: BoxDecoration(color: Colors.blue.shade100,
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
             // bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
            child: Text(widget.message.msg,
            style: const TextStyle(fontSize: 15,color: Colors.black87),),
          
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(  
                   MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
               style: const TextStyle(fontSize: 15,color: Colors.black87),),
        ),

       // SizedBox(width: mq.width * .04,)

      ],
    );
  }

 // our or user massage
  Widget _greenMessage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: mq.width * .04,),
            //double tick blue icon for message read
            if(widget.message.read.isNotEmpty)
           Icon(Icons.done_all_rounded,color: Colors.blue,size: 20,),

            SizedBox(width: 2,),
          
             //sent time
              Text(
                MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
                style: const TextStyle(fontSize: 13,color: Colors.black54),),
    
          ],
        ),
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(horizontal: mq.width *.04,vertical: mq.height * .01),
            decoration: BoxDecoration(color: Colors.lightGreen.shade100,
            border: Border.all(color: Colors.lightBlue),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
             // bottomRight: Radius.circular(30)
              )),
            child: Text(widget.message.msg,
            style: const TextStyle(fontSize: 15,color: Colors.black87),),
          
          ),
        ),
        

       // SizedBox(width: mq.width * .04,)

      ],
    );
  }

}