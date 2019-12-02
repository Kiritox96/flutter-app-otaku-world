import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  //From SplashPage to HomePage
  void navigationToNextPage() {
    Navigator.pushNamed(context, '/HomePage');
  }
  //Delay 5 secondi
  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: new Text("ciao")
    );
  }
}