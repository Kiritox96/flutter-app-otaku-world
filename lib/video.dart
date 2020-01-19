import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class VideoPage extends StatefulWidget {
  final String video;
  final ChromeSafariBrowser browser =
      new MyChromeSafariBrowser(new InAppBrowser());
  VideoPage(String video): this.video = video;
  @override
  _VideoPageState createState() => new _VideoPageState(video);
}

class _VideoPageState extends State<VideoPage> {

  InAppWebViewController webView;
  String url;
  double progress = 0;

  _VideoPageState(this.url);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  Widget landscape(){
    return new Container(
      margin: EdgeInsets.only(right: 50.0, left: 0, top: 50.0, bottom: 0),
      //child:Text(this.video)
      child: Center(
        child: RaisedButton(
        onPressed: () async {
          await widget.browser.open(
            url: "https://www.animeunityserver38.cloud/DDL/Anime/11eyes/11EyesMomoiroGenmutan_Ep_01_SUB_ITA.mp4",
            options: ChromeSafariBrowserClassOptions(
              androidChromeCustomTabsOptions: AndroidChromeCustomTabsOptions(addShareButton: false),
              //ios: IOSSafariOptions(barCollapsingEnabled: true)
            )
          );
        },
        child: Text("Open Chrome Safari Browser")),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: Container(
        //decoration: BoxDecoration(color: Colors.black),
        height: MediaQuery.of(context).size.height,
        //child: RotatedBox(
          //quarterTurns: 3,
          child:landscape()
        //)
      )
      

    );
  }
 
}
class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback) : super(bFallback: browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onLoaded() {
    print("ChromeSafari browser loaded");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}