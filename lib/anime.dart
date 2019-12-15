import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello/video.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AnimePage extends StatefulWidget {
  final dynamic anime;
  AnimePage(dynamic anime): this.anime = anime;
  @override
  _AnimePageState createState() => new _AnimePageState(anime);
}

class _AnimePageState extends State<AnimePage> {
  void showToast(String txt) {
    Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white
    );

  }
  _AnimePageState(this.anime);
  final dynamic anime;

  BoxDecoration dec(String img) {
    return new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(img),
          fit: BoxFit.cover,
        ),
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
  Widget chips(){
    return new ListView.builder(
      itemCount: this.anime['genere'].length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 120,
          height: 35,
          margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
          child: Badge(
            elevation:8.0,
            badgeColor: Colors.blueAccent,
            shape: BadgeShape.square,
            borderRadius: 8,
            toAnimate: false,
            badgeContent: Text(this.anime['genere'][index], style: TextStyle(color: Colors.white)),
          )
        );
      },
    );
  }
  BoxDecoration decFlip() {
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
  Widget episodi(){
    if(this.anime['episodi'].length > 0){
      return new ListView.builder(
        itemCount: this.anime['episodi'].length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: (){
              /*
              var activity = {
                "anime" : this.anime,
                "episodio" : this.anime['episodi'][index]
              };
              this.putActivity(activity);
               */
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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.anime['name'])
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
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                  decoration:dec(this.anime['image'])
                ),
                Container(
                  height:30,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                  child: new Text("Le trame degli anime al momento non sono disponibili",textAlign:TextAlign.center,style: TextStyle(color:Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold))
                ),
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                  child:chips()
                ),
                Divider(height: 2, color: Colors.black),
                Container(
                  height: MediaQuery.of(context).size.height - 500,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                    child:episodi()
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children:[
                      new GestureDetector(
                        onTap: () async {
                          var box = await Hive.openBox('animes');
                          var index = -1;
                          index = box.values.toList().indexOf(this.anime);
                          print(box.keys);
                          if(index != -1){
                            box.deleteAt(index);
                            this.showToast("Anime tolto dai preferiti");
                          }
                          else{
                            box.add(this.anime);
                            this.showToast("Anime aggiunto dai preferiti");
                          }
                        },
                        child: Container(child: new IconTheme(
                          data: new IconThemeData(color: Colors.yellow),
                          child: new Icon(Icons.star),
                        ))
                      ),
                      Container(
                        child: new Icon(Icons.share)
                      ),
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
