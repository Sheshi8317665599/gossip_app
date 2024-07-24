import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gossip_app/screens/splash_screen.dart';

class NativeSplashScreen extends StatelessWidget {
  const NativeSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen( 
        backgroundColor: Colors.white,
         splash:
         "assets/videos/White & Rainbow Colored Animated Color Splash Pride Month Business Sale Instagram Story.gif",
        splashIconSize: double.infinity,
        centered: true,
       nextScreen: SplashScreen(),
       duration: 1000,

       ),
    );
  }
}