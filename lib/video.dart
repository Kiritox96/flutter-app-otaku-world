import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class VideoPage extends StatefulWidget {
  final String video;
  
  VideoPage(String video): this.video = video;
  @override
  _VideoPageState createState() => new _VideoPageState(video);
}

class _VideoPageState extends State<VideoPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();  String url;

  _VideoPageState(this.url);
  
  Widget landscape(){
    return new Container(
      margin: EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
      child: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        height: MediaQuery.of(context).size.height,
        child: RotatedBox(
          quarterTurns: 3,
          child:landscape()
        )
      )
      

    );
  }
 
}