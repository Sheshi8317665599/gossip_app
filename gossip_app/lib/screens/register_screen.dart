
import 'package:flutter/material.dart';
import 'package:gossip_app/auth/auth_service.dart';
import 'package:gossip_app/components/my_button.dart';
import 'package:gossip_app/components/my_textfeild.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterScreen({super.key, required this.onTap});
   void register(BuildContext context) {

    final _auth = AuthService();

    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
        _emailController.text,
         _passwordController.text
        );
      } catch(e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.toString()),
        ),
      );
      }
      } else {
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text("password doesn,t watch!"),
        ),
      );
    }
    }
    
  

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
   body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Image.asset("assets/images/GOSSIP-removebg-preview.png"),
         ),

      
          Text(
            "Welcome back, you've been missed!",
            style: TextStyle(color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          ),
          SizedBox(height: 5),

          MyTextfeild(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
            icon: Icon(Icons.email),
          ),
  SizedBox(height: 5), 

           MyTextfeild(
            hintText: "Password",
            obscureText: true,
            controller: _passwordController,
            icon: Icon(Icons.key),
          ),
  SizedBox(height: 5),

   MyTextfeild(
            hintText: "confirmPassword",
            obscureText: true,
            controller: _confirmpasswordController,
            icon: Icon(Icons.key),
          ),
          SizedBox(height: 5),

          MyButton(
            text: "Register",
            onTap: () => register(context),
            
          ),
  SizedBox(height: 5,),
        
         Row(
          mainAxisAlignment: MainAxisAlignment.center,

           children: [
             Text("Aleardy have an account",
             style: 
             TextStyle(
              fontSize: 15.0,
              color: Theme.of(context).colorScheme.primary,),
             ),
             GestureDetector(
              onTap: onTap,
               child: Text(" Login now",
               style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
               ),
               ),
             ),
           ],
         )

        ],
      
      ),
    ),);
  }
}