import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>  _HomeScreenState();
}

class  _HomeScreenState extends State <HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('rai chat'),
        actions: [
          //search user button
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          //more features button
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
        ],
        
        ),
        backgroundColor: Color.fromARGB(26, 18, 251, 88),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(onPressed: (){},child: const Icon(Icons.add_comment_rounded),),
        ),
    );
  }
}