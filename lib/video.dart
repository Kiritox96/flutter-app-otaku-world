import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
class VideoPage extends StatefulWidget {
  final dynamic video;
  VideoPage(dynamic video): this.video = video;
  @override
  _VideoPageState createState() => new _VideoPageState(video);
}

class _VideoPageState extends State<VideoPage> with UnityAdsListener{

  _VideoPageState(this.video);
  final dynamic video;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String videoPlacementId='video';
  int _ready = 0;
  
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  @override
  initState() {
    UnityAdsFlutter.initialize(gameIdAndroid, gameIdIOS, this, true);
    _ready =0;
    super.initState();
  }
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
          child: Column(
            children:[
              Container(
                width: 200.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 0),
                child: new Text("SUB ITA",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
              ),
              Container(
                width: 200.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 0),
                child: new Text("ITA",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
              ),
              Container(
                width: 200.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 0),
                child: new Text("DOWNLOAD",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
              )
            ]
          )
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
    if(this._ready == 0){
      UnityAdsFlutter.show('video');
    }
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
  @override
  void onUnityAdsError(UnityAdsError error, String message) {
    print('$error occurred: $message');
    
  }

  @override
  void onUnityAdsFinish(String placementId, FinishState result) {
    print('Finished $placementId with $result');
  }

  @override
  void onUnityAdsReady(String placementId) {
    print('Ready: $placementId');
    /*if (placementId == videoPlacementId){
      setState(() {
        _ready++;
      });
    }*/
  }

  @override
  void onUnityAdsStart(String placementId) {
    print('Start: $placementId');
    if(placementId == videoPlacementId){
      setState(() {
        _ready++;
      });
    }
  }
}

