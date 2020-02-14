import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecorationService{
  static BoxDecoration dec(String img) {
    return new BoxDecoration(
      image: new DecorationImage(
        image: new NetworkImage(img),
        fit: BoxFit.cover,
      ),
      boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }
  static BoxDecoration decNoShadow(String img) {
    return new BoxDecoration(
      image: new DecorationImage(
        image: new NetworkImage(img),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }
  
  static BoxDecoration decFlip() {
    return new BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        new BoxShadow(
          color: Colors.black45,
          offset: new Offset(5.0, 4.0),
          blurRadius: 2.0,
        )
      ],
      color: Colors.blueAccent
    );
  }
  static BoxDecoration decWhite() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.white
    );
  }
  static BoxDecoration decFlipGrey() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.blueGrey
    );
  }
  static BoxDecoration decEvidenza() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.blue[200]
    );
  }

}