import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart';
import 'home.dart';
import 'calendario.dart';
import 'list.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // Applcation context APP
  @override
  Widget build(BuildContext context) {

    // Fixing App Orientation.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      //First page
      home: new SplashPage(),
      //Routes
      routes: <String, WidgetBuilder>{
        //Ogni route ha un proprio widget
        '/HomePage': (BuildContext context) => new HomePage(),
        '/CalendarioPage': (BuildContext context) => new CalendarioPage(),

      },
    );
  }
}