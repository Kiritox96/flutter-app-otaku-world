import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hello/activity.dart';
import 'package:hello/ricerca.dart';
import 'package:hello/util.dart';
import 'package:hive/hive.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'anime.dart';
import 'decoration.dart';
import 'preferiti.dart';
import 'rest_api.dart';
import 'calendario.dart';
import 'list.dart';
import 'ricerca.dart';
import 'SemplificataPage.dart';
import 'package:connection_status_bar/connection_status_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
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
 
  Widget evidenza(List cans) {
    return new CarouselSlider(
      height: 175.0,
      items: cans.map((i)  {
        return Builder(
          builder: (BuildContext context) {
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(i)));
              },
              child: Container(
                decoration: DecorationService.decEvidenza(),
                width: MediaQuery.of(context).size.width-10,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      decoration: DecorationService.dec(i['image']),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 3)-10,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['name'],textAlign:TextAlign.center,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['episodi'].length.toString() + " episodi",textAlign:TextAlign.center,style: TextStyle(fontSize: 15.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(i['generi'].join(' , '),textAlign:TextAlign.center,style: TextStyle(fontSize: 12.0)),
                          )
                        ],
                      )
                    )
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
                  Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    margin: EdgeInsets.all(5.0),
                    decoration: DecorationService.dec(val[0]['image'])
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    margin: EdgeInsets.all(5.0),
                    decoration: DecorationService.dec(val[1]['image'])
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    margin: EdgeInsets.all(5.0),
                    decoration: DecorationService.dec(val[2]['image'])
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
  Container grid() {
    var x = MediaQuery.of(context).size.width;
    
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[0])));
                },
                child :Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: DecorationService.decEvidenza(),
                  width: (x/4)-20,
                  child: Center(
                    child: new Icon(Icons.add_circle,size:50.0)
                  ),
                  height: 60,
                )
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[1])));
                },
                child :Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: DecorationService.decEvidenza(),
                  width: (x/4)-20,
                  child: Center(
                    child: new Icon(Icons.add_circle,size:50.0)
                  ),
                  height: 60,
                )
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[2])));
                },
                child :Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: DecorationService.decEvidenza(),
                  width: (x/4)-20,
                  child: Center(
                    child: new Icon(Icons.add_circle,size:50.0)
                  ),
                  height: 60,
                )
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[2])));
                },
                child :Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: DecorationService.decEvidenza(),
                  width: (x/4)-20,
                  child: Center(
                    child: new Icon(Icons.add_circle,size:50.0)
                  ),
                  height: 60,
                )
              ),
            ]
          ),
        ]
      )
    );
   
  }
  Widget avanzata(){
    return new  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RicercaPage()));
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
                    },
                    size: MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[0]['image']),
                    splashColor: Colors.white24,
                  ),
                   CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[1])));
                    },
                    size: MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[1]['image']),
                    splashColor: Colors.white24,
                  ),
                   CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[2])));
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
  
  Widget elenco(String txt){
    return new GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
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

  /*Widget activity(){
    return new GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Visualizza attività precedenti",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }*/
  /*Widget orList(List update){
    update.map((val)  {
        
      return  Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10.0),
        
        
      );
        
    });
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      child: new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(width: 160.0, color: Colors.blue,),
        Container(width: 160.0, color: Colors.green,),
        Container(width: 160.0, color: Colors.cyan,),
        Container(width: 160.0, color: Colors.black,),
      ],
    )
    );
  }*/
  
  Widget albero(){
    return new FutureBuilder(
        future: Future.wait([this.getPreferiti(), ApiService.getAnimeEvidenza(), ApiService.getAnimeSuggeriti()]),
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
            
            List pref = snapshot.data[0];
            List ev = snapshot.data[1];
            List sug = snapshot.data[2];
           
            
            
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
                      height: 210,
                      child:Column(
                        children:[
                          Image.asset("logo.png"),
                          Divider(height: 2, color: Colors.black)
                        ]
                      )
                    ),
                    preferiti(pref),
                    testo('In evidenza'),
                    evidenza(ev),
                    testo('Suggeriti'),
                    suggeriti(sug),
                    elenco("Preferiti"),
                    elenco("Archivio anime"),
                    avanzata(),
                    grid(),
                    
                       


                    
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
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SemplificataPage()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Passa alla versione semplificata",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }
  Widget waiting(){
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[
          CircularProgressIndicator(),
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SemplificataPage()));
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
    return new Container(
      child: albero()
    );
  }
}