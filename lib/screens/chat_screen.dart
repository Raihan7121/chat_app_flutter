import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/message_card.dart';
import 'package:flutter/cupertino.dart';

//import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key,required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<Message> _list = [];

//for handling  message text changes
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  //for storing value of showing or hiding emoji
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          //if emoji are shown & back button is pressed then hide emoji
          //or else simple close current screen on back button click
          onWillPop: (){
          if(_showEmoji){
            setState(() {
              _showEmoji = !_showEmoji;
            });
            return Future.value(false);
          }else{
            return Future.value(true);
          }
          
        },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false, //remove the back icon
              flexibleSpace: _appBar(),
            ),
                
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
                
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.user),
                    builder: (context ,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                      // return const AlertDialog(
                      //   content: CircularProgressIndicator(),
                      // );
                      return const SizedBox();
                    }
                    if (snapshot.hasError) {
                      return const SizedBox();
                      // return AlertDialog(
                      //   content: Text('Error: ${snapshot.error}'),
                      // );
                    }
                  
                          
                    //final _list = ["hii" , "hello"];
                      if(snapshot.hasData){
                        final data = snapshot.data?.docs;
                          
                       _list =data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                      
                      }
                
                
                      if(_list.isNotEmpty){
                          return ListView.builder(
                          itemCount: _list.length,
                          padding: EdgeInsets.only(top: mq.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                           // return ChatUserCard(user: _isSearching? _searchList[index] : _list[index]);
                            return MessageCard(message: _list[index]);
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
                
                  //chat user input filed
                _chatInput(),
                
                //showing emojis on keyboard emoji button click & vice versa
              //   Offstage(
              //   offstage: !_showEmoji,
              //   child: EmojiPicker(
              //     textEditingController: _textController,
              //     scrollController: _scrollController,
              //     config: Config(
              //       height: 256,
              //       checkPlatformCompatibility: true,
              //       viewOrderConfig: const ViewOrderConfig(),
              //       emojiViewConfig: EmojiViewConfig(
              //         // Issue: https://github.com/flutter/flutter/issues/28894
              //         emojiSizeMax: 28 *
              //             (foundation.defaultTargetPlatform ==
              //                     TargetPlatform.iOS
              //                 ? 1.2
              //                 : 1.0),
              //       ),
              //       skinToneConfig: const SkinToneConfig(),
              //       categoryViewConfig: const CategoryViewConfig(),
              //       bottomActionBarConfig: const BottomActionBarConfig(),
              //       searchViewConfig: const SearchViewConfig(),
              //     ),
              //   ),
              // ),       
                
                ],),
          ),
        ),
      ),
    );
  }
  Widget _appBar(){

    return InkWell(
      onTap: () {},
      child: Row(children: [
        //back button
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

  Widget _chatInput(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: mq.height * .01, horizontal: mq.width * .025
      ),
      child: Row(
        children: [ 
          Expanded(
            child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                 //emoji button
                 IconButton(onPressed: () {
                  FocusScope.of(context).unfocus();
                  setState(() => _showEmoji = !_showEmoji );
                 }, 
                 icon: Icon(Icons.emoji_emotions, color:  Colors.blueAccent,size: 25,)),
            
                 Expanded(
                  child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: () {
                    if(_showEmoji)setState(() => _showEmoji = !_showEmoji );
                  },
                  decoration:const InputDecoration(
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(color: Colors.blueAccent, ),
                    border: InputBorder.none
            
                  ),
                 )),
            
                //pic image from gallery button
                 IconButton(onPressed: () {}, 
                 icon: Icon(Icons.image, color:  Colors.blueAccent,size: 26,)),
            
                 //take image from camera button
                 IconButton(onPressed: () {}, 
                 icon: Icon(Icons.camera_alt_rounded,color: Colors.blueAccent,size: 26,)),
              ],
            ),
                  ),
          ),

          SizedBox(width: mq.width * .02,),
      
          //esnd message button
          MaterialButton(onPressed: () {
            if(_textController.text.isNotEmpty){
              APIs.sendMessage(widget.user, _textController.text);
              _textController.text ='';
            }
          },
          minWidth: 0,
          padding:const EdgeInsets.only(top: 10,bottom: 10,right: 5,left: 10),
          shape: const CircleBorder(),
          color: Colors.green,
          child: Icon(Icons.send, color: Colors.white,size: 28,),)
        ]
      ),
    );
  }
}