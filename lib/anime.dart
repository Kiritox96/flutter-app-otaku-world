import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello/util.dart';
import 'package:hello/video.dart';
import 'package:hive/hive.dart';

import 'decoration.dart';
import 'rest_api.dart';
class AnimePage extends StatefulWidget {
  final dynamic anime;
  AnimePage(dynamic anime): this.anime = anime;
  @override
  _AnimePageState createState() => new _AnimePageState(anime);
}

class _AnimePageState extends State<AnimePage> {
  
       

  _AnimePageState(this.anime);
  final dynamic anime;
  
  Widget detail(dynamic an){
    return new Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: DecorationService.dec(an['image'])
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(an['episodi'].length.toString() + " episodi",textAlign:TextAlign.left,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
              ),
              Container(
                width:150,
                margin: EdgeInsets.all(10.0),
                child:  Text(an['generi'].join(' , '),textAlign:TextAlign.center,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)) ,
              ),
              
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.anime['name'])
      ),
      body: new Container(
        child: animeDetail(this.anime)
      )
    );
  }
  Widget animeDetail(dynamic an){
    return new SingleChildScrollView(
      child: new Column(
        children: [
          ConnectionStatusBar(),
          all(an)
        ]
      )
    );
  }
  Widget all(an){
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          detail(an),
         
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
