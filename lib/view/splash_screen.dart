import 'package:flutter/material.dart';

import 'buttom_navbar.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigater();
  }

  Future<void> _navigater() async {
    await Future.delayed(Duration(seconds: 3));
    // User is logged in, navigate to NewsRoom
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text( "Welcome to Notepad", style: TextStyle(color: Colors.white,fontSize: 24)),
      ),
    );
  }
}