import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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

  Widget landscape(){
    return Container(
      margin: EdgeInsets.only(right: 50.0, left: 50.0, top: 0, bottom: 0),
      child: WebView(
        initialUrl: this.video['episodio'][1],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        }
      )
    );

  }
  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.white70,
          ),
        ]
      ),
      margin: const EdgeInsets.all(24.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text("This is the SlidingUpPanel when open"),
        ),
      )
    );
  }
  Widget _floatingCollapsed(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Center(
        child: new Icon(Icons.arrow_upward)
      )
    );
  }
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SlidingUpPanel(
        renderPanelSheet: false,
        color: Color.fromRGBO(0, 0, 0, 100.0),
        minHeight: 50.0,
        maxHeight: 250.0,
        collapsed: _floatingCollapsed(),
        panel: _floatingPanel(),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          height: MediaQuery.of(context).size.height,
          child: RotatedBox(
            quarterTurns: 3,
            child:landscape()
          )
        )
      ),

    );
  }
}

