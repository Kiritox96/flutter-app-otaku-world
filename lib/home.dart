import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flurry/flurry.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';
import 'activity.dart';
import 'auth.dart';
import 'listManga.dart';
import 'listMangaEngPage.dart';
import 'ricerca.dart';
import 'package:hive/hive.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'anime.dart';
import 'decoration.dart';
import 'preferiti.dart';
import 'rest_api.dart';
import 'list.dart';
import 'SemplificataPage.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'swipe.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future<void> initFlurry() async {

    await Flurry.initialize(androidKey: "3926DZDM6WKBK73SCS48", iosKey: "6GD25QCHX74HKWKP7RQT", enableLog: true);
    String id = await _getId();
    Flurry.setUserId(id);
    Flurry.logEvent("Init App");

  }
  Future<String> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  void initState() {
    super.initState();
    initFlurry();
  }

  @override
  Widget build(BuildContext context) {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
      },
    );
    return new Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: MainPage()
    );
  }
}



class MainPage extends StatefulWidget {
  
 @override
 _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  Widget evidenza(List cans) {
    return new CarouselSlider(
      height: 175.0,
      items: cans.map((i)  {
        return Builder(
          builder: (BuildContext context) {
            return  GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(i)));
                Flurry.logEvent("Click anime " + i['name']);
              },
              child: Container(
                decoration: DecorationService.decEvidenza(),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child:Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      decoration: DecorationService.decNoShadow(i['image']),
                    )),
                    Expanded(child:Container(
                      width: (MediaQuery.of(context).size.width / 3)-10,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child:Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['name'],textAlign:TextAlign.center,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                          )),
                          Expanded(child:Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['episodi'].length.toString() + " episodi",textAlign:TextAlign.center,style: TextStyle(fontSize: 15.0)),
                          )),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['generi'].join(' , '),textAlign:TextAlign.center,style: TextStyle(fontSize: 12.0)),
                          )
                        ],
                      )
                    ))
                  ]
                )
              )
            );
          },
        );
      }).toList(),
    );
  }
  Widget suggeriti(List done) {
    List sug = [];
    for( int i = 0; i<done.length;i=i+3){
      List nn = [];
      nn.add(done[i]);
      nn.add(done[i+1]);
      nn.add(done[i+2]);
      sug.add(nn);
    }
    return new CarouselSlider(
      height: 150.0,
      items: sug.map((val)  {
        return Builder(
          builder: (BuildContext context) {
            return  Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(val[0])));
                      Flurry.logEvent("Click anime " + val[0]['name']);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      margin: EdgeInsets.all(2.0),
                      decoration: DecorationService.dec(val[0]['image'])
                    )
                  ),
                  GestureDetector(
                    onTap: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(val[1])));
                      Flurry.logEvent("Click anime " + val[1]['name']);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      margin: EdgeInsets.all(2.0),
                      decoration: DecorationService.dec(val[1]['image'])
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(val[2])));
                      Flurry.logEvent("Click anime " + val[2]['name']);

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      margin: EdgeInsets.all(2.0),
                      decoration: DecorationService.dec(val[2]['image'])
                    )
                  )
                  
                ],
              )
            );
          },
        );
      }).toList(),
    );
  }
  Container testo(String txt){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child:Text(txt,textAlign:TextAlign.left,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
    );
  }
  Widget avanzata(){
    return new  GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RicercaPage()));
        Flurry.logEvent("Click ricerca");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        child: new Text("Ricerca avanzata",textAlign:TextAlign.right,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
      )
    );
  }
  Future<List<dynamic>> getPreferiti() async {
    var box = await Hive.openBox('animes');
    return box.values.toList();
  }
  Widget preferiti(List preferiti){
    if (preferiti.length > 2) {
      return new Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10.0),
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: new Text("I tuoi preferiti",textAlign:TextAlign.left,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child:Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[0])));
                      Flurry.logEvent("Click anime " + preferiti[0]['name']);
                    },
                    
                    size: MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[0]['image']),
                    splashColor: Colors.white24,
                  ),
                   CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[1])));
                      Flurry.logEvent("Click anime " + preferiti[1]['name']);
                    },
                    size: MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[1]['image']),
                    splashColor: Colors.white24,
                  ),
                   CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[2])));
                      Flurry.logEvent("Click anime " + preferiti[2]['name']);
                    },
                    size: MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[2]['image']),
                    splashColor: Colors.white24,
                  ) 
                ]
              )
            )
          ]
        )
      );
    }
    else{
      return SizedBox.shrink();
    }
  }
  Widget swipe(dynamic an){
    return new Container(
      height:70.0,
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      alignment: Alignment.center,
      child: SwipeButton(
        thumb: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(widthFactor: 0.90,child: Icon(Icons.chevron_right,size: 60.0,color: Colors.white)),
          ],
        ),
        content: Center(child: Text("RANDOM",style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold))),
        onChanged: (result) {
          if (result == SwipePosition.SwipeRight) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(an)));
            Flurry.logEvent("Swipe random " + an['name']);
          } else {}
        },
      ),
      
    );
  }
  
  
  Widget elenco(String txt){
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PreferitiPage()));
        Flurry.logEvent("Click preferiti ");
      },
      child: new Container(
        height:50,
        decoration: DecorationService.decEvidenza(),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children:[
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              child: new Text(txt,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              child: new Icon(Icons.arrow_forward_ios)
            )
          ]
        )
      )
    );
  }

  Widget activity(){
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage()));
          Flurry.logEvent("Click activity ");
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            child: new Text("Visualizza attività precedenti",textAlign:TextAlign.center,style: TextStyle(color:Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }
  
  Widget albero(){
    return new FutureBuilder(
        future: Future.wait([this.getPreferiti(), ApiService.getAnimeEvidenza(), ApiService.getAnimeSuggeriti(), ApiService.randomAnime()]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List pref = snapshot.data[0];

            List ev = snapshot.data[1];
            List sug = snapshot.data[2];
            dynamic ran = snapshot.data[3];
            return new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  children: [
                    ConnectionStatusBar(),
                    Container(
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 0),
                      width: MediaQuery.of(context).size.width,
                      color: Color(0x060606),
                      height: 270,
                      child:Column(
                        children:[
                          Image.asset("logo.png"),
                          profilo(),
                          Divider(height: 2, color: Colors.black)
                        ]
                      )
                    ),
                    preferiti(pref),
                    testo('In evidenza'),
                    evidenza(ev),
                    testo('Suggeriti'),
                    suggeriti(sug),
                    activity(),
                    elenco("Preferiti"),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: new Container(
                                height: 150,
                                width:MediaQuery.of(context).size.width - 100,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.all(1.0),
                                        child:Center(
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child:  new Icon(Icons.view_carousel, size: 40.0),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListMangaPage()));
                                                },
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                child: Text(
                                                  "MANGA ITA",
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListMangaEngPage()));
                                                },
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                child: Text(
                                                  "MANGA ENG",
                                                ),
                                              ),
                                            ],
                                          )
                                        ),
                                      ),
                                      new Text("O"),
                                      new Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child:Center(
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child:  new Icon(Icons.ondemand_video, size: 40.0),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
                                                },
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                child: Text(
                                                  "ANIME",
                                                ),
                                              ),
                                            ],
                                          )
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ),
                            );
                          }
                        );
                        Flurry.logEvent("Click list ");
                      },
                      child: new Container(
                        height:50,
                        decoration: DecorationService.decEvidenza(),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children:[
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                              child: new Text("Anime & Manga",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                              child: new Icon(Icons.arrow_forward_ios)
                            )
                          ]
                        )
                      )
                    ),
                    //avanzata(),
                    swipe(ran),
                    semplificata()
                  ]
                )
              )
            );
          }
          return waiting();
        }
    );
  }
  
  
 
  
  Widget semplificata(){
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SemplificataPage()));
          Flurry.logEvent("Click semplificata ");
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Passa alla versione semplificata",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }
  Widget profilo(){
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          Flurry.logEvent("Click login ");
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Vai alle funzioni cloud",textAlign:TextAlign.right,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }
  void putEvidenza(List ev) async {
    var box = await Hive.openBox('evidenza');
    box.add(ev);
  }
  void putSuggeriti(List sug) async {
    var box = await Hive.openBox('suggeriti');
    box.add(sug);
  }
  Widget waiting(){
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Il caricamento può richiedere anche più di 20 secondi",textAlign:TextAlign.center,style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold))
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
              child: new Text("Consigliamo di passare alla connessione WiFi",textAlign:TextAlign.center,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
              child: new Text("OPPURE",textAlign:TextAlign.center,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold))
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SemplificataPage()));
              Flurry.logEvent("Click semplificata ");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 0),
              child: new Text("Passa alla versione semplificata",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
            )
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return albero();
  }
}