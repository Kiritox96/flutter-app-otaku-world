import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_ink_well/image_ink_well.dart';

import 'anime.dart';
import 'decoration.dart';

class UtilService{
  static void showToast(String txt) {
    Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white
    );

  }
  static Container logo(BuildContext context){
    return new Container(
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 0),
        width: MediaQuery.of(context).size.width,
        color: Color(0x060606),
        height: 210,
        child:Column(
          children:[
            Image.asset("logo.png"),
            Divider(height: 2, color: Colors.black)
          ]
        )
    );
  }
  static Widget circleImage(BuildContext context,dynamic preferiti ){
    return CircleImageInkWell(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti)));
      },
      size: MediaQuery.of(context).size.width/4,
      image: NetworkImage(preferiti['image']),
      splashColor: Colors.white24,
    );
  }
  static Widget carousel(List done) {
    return new CarouselSlider(
      height: 175.0,
      items: done.map((i)  {
        return Builder(
          builder: (BuildContext context) {
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(i)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                decoration: DecorationService.dec(i['image']),

              )
            );
          },
        );
      }).toList(),
    );
  }
}