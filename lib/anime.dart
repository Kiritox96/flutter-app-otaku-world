import 'package:flutter/material.dart';
import 'video.dart';
import 'package:hive/hive.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';

import 'decoration.dart';
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
  String videoPlacementId='video';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  String link = "";
  
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
                Expanded(child:Container(
                  margin: EdgeInsets.only(right: 20.0, left: 10.0, top: 10.0, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(an['trama'],textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),maxLines: 10)
                ))
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
  void putActivity(dynamic activity) async {
    var box = await Hive.openBox('activities');
    box.add(activity);
  }
  Future<List<dynamic>> getActivity() async {
    var box = await Hive.openBox('activities');
    return box.values.toList();
  }
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(this.link)));

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
  Widget episodi(){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              var box = await Hive.openBox('animes');
              var index = -1;
              index = box.values.toList().indexWhere((val)=>val['name'] == this.anime['name']);
              if(index != -1){
                box.deleteAt(index);
                this.snack("Anime tolto dai preferiti");
              }
              else{
                box.add(this.anime);
                this.snack("Anime aggiunto ai preferiti");
              }
            },
            child:Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width,
              child:Text("Aggiungi ai preferiti",textAlign:TextAlign.right,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.blue[200]))
            ),
          ),
          Divider(height: 2,color: Colors.black),
          testo('Episodi'),
          Container(
            width: MediaQuery.of(context).size.width ,
            height: 230,
            child: gridView(this.anime),
          ),
          
        ]
      )
    );
  }
  void snack(String txt){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(txt),duration: Duration(seconds: 3)));
  }
  Widget gridView(dynamic an) {
    return new FutureBuilder(
      future: Future.wait([this.getActivity()]),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List val = snapshot.data[0];
          return GridView.count(
            crossAxisCount: 6,
            children: List.generate(an['episodi'].length, (index) {
              return Center(
                child:GestureDetector(
                  onTap: (){
                    var activity = {
                      "anime" : an['name'],
                      "episodio" : index.toString()
                    };
                    this.putActivity(activity);
                    setState((){
                      _ready=false;
                      link = an['episodi'][index].toString();
                    });
                    UnityAdsFlutter.show('video');
                  },
                  child: Container(
                    child: Text((index + 1).toString(),style: TextStyle(
                      color: val.where((v)=>v['anime']==an['name']).where((c)=>c['episodio'] == index.toString()).length > 0 ? Colors.red : Colors.black, 
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    )),
                  ) 
                )
              );
            })
          );
        } else {
          return CircularProgressIndicator();

        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(this.anime['name'])
      ),
      body: new SingleChildScrollView(
        child:new Container(
          height: MediaQuery.of(context).size.height,
          child: Column(    
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    detail(this.anime),
                    episodi()
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }
  
}
 