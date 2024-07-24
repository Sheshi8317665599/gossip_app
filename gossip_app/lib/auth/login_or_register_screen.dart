import 'package:flutter/material.dart';
import 'package:gossip_app/screens/login__screen.dart';
import 'package:gossip_app/screens/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
   bool ShowLoginPage = true;

   void togglePages() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
      });
   }
  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      ); 
    } else {
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}