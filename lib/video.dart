import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class VideoPage extends StatefulWidget {
  final dynamic video;
  VideoPage(dynamic video): this.video = video;
  @override
  _VideoPageState createState() => new _VideoPageState(video);
}

class _VideoPageState extends State<VideoPage> {

  _VideoPageState(this.video);
  final dynamic video;
  final Completer<WebViewController> _controller = Completer<WebViewController>();



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(this.video['episodio'][0])
        ),
        body: new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: new  Column(
                        children:[
                          Container(
                            child: WebView(
                            initialUrl: this.video['episodio'][1],
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: (WebViewController webViewController) {
                                _controller.complete(webViewController);
                              }
                            ),
                            height: 300.0,
                          ),

                        ]
                    )
                )
            )
        )
    );
  }

}
