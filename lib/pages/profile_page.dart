import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  //future to user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async{
    return await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //    elevation: 0,
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Profile"),),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context,snapshot){
            //loading..
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //error
            else if(snapshot.hasError){
              return Center(
                child: Text("Error: ${snapshot.error}")
              );
            }

            //data received
            else if(snapshot.hasData){
              //extract data
              Map<String,dynamic>? user  = snapshot.data!.data();
              return Center(
                child: Column(
                  children: [
                   
                     const Padding(
                       padding: EdgeInsets.only(top:80.0,left:25),
                       child: Row(
                         children: [
                           Back(),
                         ],
                       ),
                     ),
                     const SizedBox(height: 25,),
                    //profile pic
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary),
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Icon(Icons.person,size: 64,),
                      ),
                    ),

                    const SizedBox(height: 25,), 

                    //username
                    Text(user!["username"],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                    //email 
                    Text(user!["email"],style: TextStyle(color: Colors.grey[600]),),
                    
                  ],
                ),
              );
            }
            else{
              return Text("no data");
            }

            

          }
        ),
    );
  }
}