import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/auth/login_or_register_screen.dart';
import 'package:gossip_app/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return HomeScreen();
        }

        else{
          return const LoginOrRegisterScreen();
        }
      },
      ),
    );
  }
}