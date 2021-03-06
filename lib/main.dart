import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'splash.dart';
import 'home.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // need to be the first line in main method
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 
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

      },
    );
  }

}