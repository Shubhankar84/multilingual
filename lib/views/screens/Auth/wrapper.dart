import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flyin/controller/auth_controller.dart';
import 'package:flyin/views/screens/Auth/login_screen.dart';
import 'package:flyin/views/screens/home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return AuthController.instance.checkUserInFirestore();
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
