/*

this database store post that user have published
it is stored in a collection vall "POST" in the firestore database

Each post container
message
email of the user
timestamp

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  //get collection of posts from firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection("Posts");

  //post message
  Future<void> addPost(String message){
    return posts.add({
     'UserEmail': user!.email,
     'Message':message,
     'TimeStamp':Timestamp.now() 
    });
  }
 
  //read message from firebase
  Stream<QuerySnapshot> getPostsStream(){
    final postsStream = FirebaseFirestore.instance.collection("Posts").orderBy('TimeStamp',descending: true).snapshots(); 
  return postsStream;
  }
} 