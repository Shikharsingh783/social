import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/auth/auth.dart';
import 'package:social/auth/login_or_register.dart';
import 'package:social/pages/home_page.dart';
import 'package:social/pages/profile_page.dart';
import 'package:social/pages/user_page.dart';
import 'package:social/theme/dark_mode.dart';
import 'package:social/theme/light_mode.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     theme: lightMode,
     darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        '/login_register_page':(context) => const LoginOrRegister(),
        '/home_page':(context) => HomePage(),
        '/profile_page':(context) => ProfilePage(),
        '/users_page':(context) => const UserPage()
      },
    );
  }
}

