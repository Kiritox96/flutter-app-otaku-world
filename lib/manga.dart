import 'package:OtakuWorld/rest_api.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'capitolo.dart';
import 'package:hive/hive.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';

import 'decoration.dart';
class MangaPage extends StatefulWidget {
  String id;
  String titolo;
  MangaPage(String id, String titolo){
    this.id = id;
    this.titolo = titolo;
  }
  @override
  _MangaPageState createState() => new _MangaPageState(id, titolo);
}

class _MangaPageState extends State<MangaPage> with UnityAdsListener{
  UnityAdsError _error;
  String _errorMessage;
  bool _ready;
  _MangaPageState(this.id, this.titolo);
  final String titolo;
  final String id;
  String videoPlacementId='video';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  String link = "";
  
  Widget detail(dynamic manga){
    return new Container(
      width: MediaQuery.of(context).size.width  ,
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            margin: EdgeInsets.all(10.0),
            decoration: DecorationService.dec('https://cdn.mangaeden.com/mangasimg/' + manga['image']),
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
                  child: Text(manga['description'],textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),maxLines: 10)
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => CapitoloPage(this.link)));

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
  Widget episodi(dynamic manga, List activity){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         
          Divider(height: 2,color: Colors.black),
          testo('Capitoli'),
          Container(
            width: MediaQuery.of(context).size.width ,
            height: 230,
            child: gridView(manga, activity),
          ),
          
        ]
      )
    );
  }
  Widget gridView(dynamic manga, List activity) {
    if(manga['chapters'].length > 0){
      return GridView.count(
        crossAxisCount: 6,
        children: List.generate(manga['chapters'].length-1, (index) {
          return Center(
            child:GestureDetector(
              onTap: (){
                print(index);
                var activity = {
                  "anime" : manga['title'],
                  "episodio" : index.toString()
                };
                this.putActivity(activity);
                setState((){
                  _ready=false;
                  link = manga['chapters'][manga['chapters'].length - index - 1 ][3].toString();
                });
                UnityAdsFlutter.show('video');
              },
              child: Container(
                child: Text((manga['chapters'][manga['chapters'].length - index - 1 ][0]).toString(),style: TextStyle(
                  color: activity.where((v)=>v['anime']==manga['title']).where((c)=>c['episodio'] == index.toString()).length > 0 ? Colors.red : Colors.black, 
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                )),
              ) 
            )
          );
        })
      );
    } 
    else {
      return Center(
        child: new Text("Non sono stati trovati risultati",textAlign:TextAlign.center,style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold)),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(this.titolo)
      ),
      body: new FutureBuilder(
        future: Future.wait([ApiService.getSingleManga(this.id),this.getActivity()]),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            dynamic val = snapshot.data[0];
            List act = snapshot.data[1];
            return new SingleChildScrollView(
              child:new Container(
                height: MediaQuery.of(context).size.height,
                child: Column(    
                  children: [
                    ConnectionStatusBar(),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          detail(val),
                          episodi(val, act)
                        ],
                      )
                    )
                  ]
                )
              )
            );
          } else {
            return Center(
              child:CircularProgressIndicator()
            );
          }
        }
      )
  
          
         
    );
  }
  
}
 