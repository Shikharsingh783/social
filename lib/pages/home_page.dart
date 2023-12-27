import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_drawer.dart';
import 'package:social/components/my_list_tile.dart';
import 'package:social/components/my_post_button.dart';
import 'package:social/components/textfeild.dart';
import 'package:social/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //controller
  final TextEditingController NewPostController =  TextEditingController();

  //post message
  void PostMessage(){
    //only post messagae if there is something inthe textfeild
    if(NewPostController.text.isNotEmpty){
      String message = NewPostController.text;
      database.addPost(message);
    }

    //clear the conjtroller
    NewPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary  ,
        title: Text("W A L L"),
       
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          //textfeild box for the user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfeild(
                    hintText: "Say something...",
                     obsecureText: false,
                      controller: NewPostController),
                ),
                PostButton(ontap: PostMessage,)
              ],
            ),
          ),

          //posts
          StreamBuilder(stream: database.getPostsStream(),
           builder: (context,snapshot){
            //show loading circle
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //get all post
            final posts = snapshot.data!.docs;

            //no data?
            if(snapshot.data == null || posts.isEmpty){
              return const Center(
                child: Padding(padding: EdgeInsets.all(25),
                child: Text("No post.. Post Something!"),
                ),
              );
            }

            // return as  a list
            return Expanded(child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context,index){
              //get each indivisual post
              final post = posts[index];


              //get data from each post
              String message = post['Message'];
              String userEmail = post['UserEmail'];
              // Timestamp timestamp = post['Timestamp'];
        
              //return as a list tile

              return MyListTile(title: message, subtitle: userEmail);
            }));
           }
           )
        ],
      ),
    );
  }
}