import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/button.dart';
import 'package:social/components/textfeild.dart';
import 'package:social/helper/helper_funtion.dart';

class RegisterPage extends StatefulWidget {

  final void Function()? ontap;


  RegisterPage({super.key, this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  //login
  void registerUser() async{
    //make laodiing
    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));

    //make sure password match
    if(passwordController.text != confirmPasswordController.text){
      //pop loading circle
      Navigator.pop(context);

      //show display message to the user
      displayMessageToUser("Passwords don't match" , context); 
    }

    //register user
    else{
      try{
      UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      //create a user document and add to firestore
      createUserDocument(userCredential);

    //pop the circle
    Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      //pop loading circle
      Navigator.pop(context);

      //show display message to the user
      displayMessageToUser(e.code, context);
    }
    }

  }

  Future<void> createUserDocument(UserCredential? userCredential)async{
    if(userCredential !=null  && userCredential.user != null){
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.email).set({
        "email": userCredential.user!.email,
        "username": usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(Icons.person,
              size: 80,color: Theme.of(context).colorScheme.inversePrimary,),
              const SizedBox(height: 25,),
              //app name
              const Text("S O C I A L",style:TextStyle(fontSize: 20),),
              const SizedBox(height: 50,),
              //email feild
             MyTextfeild(hintText: "Username", obsecureText: false, controller: usernameController),
             const SizedBox(height: 10,),
                            MyTextfeild(hintText: 'Email',
               obsecureText: false,
                controller: emailController),
                const SizedBox(height: 10,), 
              //textfeild 
              MyTextfeild(hintText: 'Password',
               obsecureText: true,
                controller: passwordController),
                SizedBox(height:10),
                MyTextfeild(hintText: "Confirm Password", obsecureText: true, controller: confirmPasswordController),
                //forgot password`
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("forgot password?",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                  ],
                ),
                const SizedBox(height: 25,),

                //sign in button
                MyButton(text:"Register",ontap: registerUser),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(" Register here",style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}