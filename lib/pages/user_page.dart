import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_back_button.dart';
import 'package:social/components/my_list_tile.dart';
import 'package:social/helper/helper_funtion.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context,snapshot){
          //any error
          if(snapshot.hasError){
            displayMessageToUser("something went wrong", context);
          }

          //show loading cirlce
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data == null){
            return const Text("No data");
          }

          //get user
          final users = snapshot.data!.docs;
          return Column(
            children: [
               const Padding(
                       padding: EdgeInsets.only(top:80.0,left:25),
                       child: Row(
                         children: [
                           Back(),
                         ],
                       ),
                     ),
                    //list os users in the app
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context,index){
                    //get indivisual user
                    final user = users[index];
                    //get data from each user
                    String username = user['username'];
                    String email = user['email'];
                    return MyListTile(title: username, subtitle: email);
                  }
                  ),
              ),
            ],
          );

        }
      ),
    );
  }
}