import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/components/button.dart';
import 'package:social/components/textfeild.dart';
import 'package:social/helper/helper_funtion.dart';

class LoginPage extends StatefulWidget {
  final void Function()? ontap;
  const LoginPage({super.key, this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  //login
  void login() async{
    //showloading circle
    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    
    //pop loading circle
    if(context.mounted) Navigator.pop(context);
    }

    //display error message
    on FirebaseAuthException catch(e){
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
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
                            MyTextfeild(hintText: 'Email',
               obsecureText: false,
                controller: emailController),
                const SizedBox(height: 10,), 
              //textfeild 
              MyTextfeild(hintText: 'Password',
               obsecureText: true,
                controller: passwordController),

                //forgot password`
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("forgot password?",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                  ],
                ),
                const SizedBox(height: 25,),

                //sign in button
                MyButton(text:"Login",ontap: login,),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    GestureDetector(
                      onTap:widget.ontap,
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