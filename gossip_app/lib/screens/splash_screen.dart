import 'package:flutter/material.dart';
import 'package:gossip_app/auth/auth_gate.dart';
import 'package:gossip_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/chat_app_login_image-removebg-preview.png'),
              
              Text(
                'Connect easily with\n your family and friends\n over countries',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0),
              Text(
                'Terms & Privacy Policy',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, 
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthGate(),
                    ),
                  );
                },
                child: Text(
                  'Start Messaging',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


