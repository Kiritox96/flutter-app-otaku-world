import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello/util.dart';
import 'package:hello/video.dart';
import 'package:hive/hive.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';

import 'decoration.dart';
import 'rest_api.dart';
class AnimePage extends StatefulWidget {
  final dynamic anime;
  AnimePage(dynamic anime): this.anime = anime;
  @override
  _AnimePageState createState() => new _AnimePageState(anime);
}

class _AnimePageState extends State<AnimePage> with UnityAdsListener{
  UnityAdsError _error;
  String _errorMessage;
  bool _ready;
  _AnimePageState(this.anime);
  final dynamic anime;
  Widget detail(dynamic an){
    return new Container(

      width: MediaQuery.of(context).size.width  ,
      margin: EdgeInsets.all(10.0),
     // decoration: DecorationService.decEvidenza(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            height: 200,
            margin: EdgeInsets.all(10.0),
            decoration: DecorationService.dec(an['image']),
            width: MediaQuery.of(context).size.width / 3.5,
          ),
          Container(
            height: 200,
             width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 3.5) - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child:Text("Trama",textAlign:TextAlign.left,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0, left: 10.0, top: 10.0, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(an['trama'],textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),maxLines: 10)
                )
              ],
            )
          )
         
          

          
        ],
      )
    );
  }
  Container testo(String txt){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child:Text(txt,textAlign:TextAlign.left,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
    );
  }
  
  String videoPlacementId='video';
  
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  @override
  initState() {
    UnityAdsFlutter.initialize(gameIdAndroid, gameIdIOS, this, true);
    _ready = false;
    super.initState();
  }
 @override
  void onUnityAdsError(UnityAdsError error, String message) {
    print('$error occurred: $message');
    setState((){
      this._error=error;
      this._errorMessage=message;
    });
  }

  @override
  void onUnityAdsFinish(String placementId, FinishState result) {
    print('Finished $placementId with $result');
  }

  @override
  void onUnityAdsReady(String placementId) {
    print('Ready: $placementId');
    if (placementId == videoPlacementId){
      setState(() {
        this._ready=true;
      });
    }
  }

  @override
  void onUnityAdsStart(String placementId) {
    print('Start: $placementId');
    if(placementId == videoPlacementId){
      setState(() {
        this._ready = false;
      });
    }
  }
  Widget episodi(dynamic an){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(height: 2,color: Colors.black),
          testo('Episodi'),
          Container(
            width: MediaQuery.of(context).size.width ,
            height: 300,
            child: gridView(an),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            width: MediaQuery.of(context).size.width,
            child:Text("Aggiungi ai preferiti",textAlign:TextAlign.right,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.blue[200]))
          ),
        ]
      )
    );
  }
  Widget gridView(dynamic an) {
    return GridView.count(
      crossAxisCount: 8,
      children: List.generate(an['episodi'].length, (index) {
        return Center(
          child:GestureDetector(
            onTap: (){
              /*UtilService.showToast(
                an['episodi'][index]
              );*/
              /*showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Alert Dialog title"),
                    content: new Text(an['episodi'][index]),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );*/
              //String vid = an['episodi'][index]
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(an['episodi'][index].toString())));
            },
            child: Container(
              child: Text((index + 1).toString(),style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),
            ) 
          )
          
        );
      })
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.anime['name'])
      ),
      body: new Container(
        height: MediaQuery.of(context).size.height,

        child: animeDetail(this.anime)
      )
    );
  }
  Widget animeDetail(dynamic an){
    return  new Column(    
      children: [
        ConnectionStatusBar(),
        all(an)
      ]
    );
  
  }
  Widget all(an){
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          detail(an),
          episodi(an)
        ],
      )
    );
  }
}
 
  /*Widget episodi(){
    if(this.anime['episodi'].length > 0){
      return new ListView.builder(
        itemCount: this.anime['episodi'].length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: (){
              
              var activity = {
                "anime" : this.anime,
                "episodio" : this.anime['episodi'][index]
              };
              this.putActivity(activity);
               
              var video = {
                "anime" : this.anime,
                "episodio" : this.anime['episodi'][index],
              };
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(video)));
            },
            child: new Container(
              height:35,
              decoration: decFlip(),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children:[
                  Container(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                    child: new Text((index+1).toString(),overflow: TextOverflow.ellipsis,style: TextStyle(color:Colors.white,fontSize: 15.0))
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                    child: new Text(this.anime['episodi'][index][0],style: TextStyle(color:Colors.white,fontSize: 15.0))
                  )
                ]
              )
            )
          );
        },
      );
    }
    return new Center(
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
          child: new Text("Non sono ancora stati caricati episodi per questo anime",textAlign:TextAlign.center,style: TextStyle(color:Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold))
      )
    );

  }

  void putActivity(dynamic activity) async {
    var box = await Hive.openBox('activities');
    box.add(activity);
  }*/
