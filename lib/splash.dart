import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

import 'home.dart';

class SplashPage extends StatefulWidget {

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: AnimatedSplash(
        imagePath: 'assets/logo.png',
        home: HomePage(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
    );
  }
}