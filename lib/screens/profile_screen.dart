
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/apis.dart';
import 'package:chat_app/helper/dialogs.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '../widgets/chat_user_card.dart';


class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() =>  _ProfileScreenState();
}

class  _ProfileScreenState extends State <ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    
        title: const Text('profile screen'),
        
        ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.height * .05),
        child: Column(
          children: [
            SizedBox(width: mq.width,height: mq.height* .03,),
            Stack(
              children: [
                ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height*.1),
                        child: CachedNetworkImage(
                            height: mq.height * .2,
                            width: mq.height * .2,
                            fit: BoxFit.fill,
                            imageUrl: "http://via.placeholder.com/350x150",
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: (){},
                        shape: CircleBorder(),
                        color: Colors.white,
                        child: Icon(Icons.edit),),
                      )
              ],
            ),

                  SizedBox(height: mq.height* .03,),

                  Text(widget.user.email,style: TextStyle(color: Colors.black54,fontSize: 16),),

                   SizedBox(height: mq.height* .05,),

                  TextFormField(
                    initialValue: widget.user.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.blue,) , 
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText:'eg. raj rai',
                      label : Text('Name')),
                      
                  ),

                   SizedBox(height: mq.height* .02,),

                  TextFormField(
                    initialValue: widget.user.about,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline,color: Colors.blue,) , 
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText:'eg. feeling happy',
                      label : Text('About')),
                      
                  ),

                  SizedBox(height: mq.height* .03),
                
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.width * .5, mq.height* .08),
                    ),
                    onPressed: (){}, icon: Icon(Icons.edit,size: 30,),label: Text('update',style: TextStyle(fontSize: 16),),)

          ],
        ),
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
            
            Dialogs.showProcessBar(context);
            await APIs.auth.signOut().then((Value) async{
              // await GoogleSignIn().signOut();
              //pop up dialog
              Navigator.pop(context);
              //pop up login screen
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            }); 
           
          },
          icon: const Icon(Icons.logout),
          label: Text('logout'),),
        ),
      
     
        );

  }
}