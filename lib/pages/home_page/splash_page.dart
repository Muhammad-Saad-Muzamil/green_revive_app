import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenreviveapp/pages/onboarding_pages/onboarding_screen';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override

  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override

  void initState()  
  {
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnboardingScreen()),);
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: 
          <Widget>[
            Image.asset('images/leaf.png' , height: 50,width: 50,),
            const SizedBox(height: 20),
             const Text(
              '"Smart Solutions for a Cleaner Tomorrow."',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
          ],
        
        
        ),
      ),
      
    );
  }
}