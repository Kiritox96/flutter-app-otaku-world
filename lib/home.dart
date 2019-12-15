import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hello/activity.dart';
import 'package:hello/login.dart';
import 'package:hello/ricerca.dart';
import 'package:hive/hive.dart';
import 'anime.dart';
import 'rest_api.dart';
import 'calendario.dart';
import 'list.dart';
import 'ricerca.dart';
import 'SemplificataPage.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted){
      setState(() {});
    }
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,

      body: SmartRefresher(
        enablePullDown: true,
        //enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: MainPage()
      )
    );
  }
}



class MainPage extends StatefulWidget {
 @override
 _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
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
  BoxDecoration decFlipGrey() {
    return new BoxDecoration(
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

  Widget evidenza(List cans) {
    return new CarouselSlider(
      height: 175.0,
      items: cans.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(i)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                decoration: dec(i['image']),

              )
            );
          },
        );
      }).toList(),
    );
  }
  Widget suggeriti(List done) {
    return new CarouselSlider(
      height: 175.0,
      items: done.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(i)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
                decoration: dec(i['image']),

              )
            );
          },
        );
      }).toList(),
    );
  }
  Container testo(String txt){
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child:Text(txt,textAlign:TextAlign.left,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))
    );
  }
  Container grid(List today) {
    var x = MediaQuery.of(context).size.width;
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[0])));
                    },
                    child :Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: dec(today[0]['image']),
                      width: (x/2)-20,
                      height: 150,
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[1])));
                    },
                    child :Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: dec(today[1]['image']),
                      width: (x/2)-20,
                      height: 150,
                    )
                  ),
                ]
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[2])));
                    },
                    child :Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: dec(today[2]['image']),
                      width: (x/2)-20,
                      height: 150,
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(today[3])));
                    },
                    child :Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: dec(today[3]['image']),
                      width: (x/2)-20,
                      height: 150,
                    )
                  )
                ]
              )
            ]
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarioPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
              child: new Text("Vedi calendario completo",textAlign:TextAlign.right,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
            )
          )

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
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
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
                    size:  MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[1]['image']),
                    splashColor: Colors.white24,
                  ),
                  CircleImageInkWell(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[2])));
                    },
                    size:  MediaQuery.of(context).size.width/4,
                    image: NetworkImage(preferiti[2]['image']),
                    splashColor: Colors.white24,
                  )
                ],
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: new Text("Visualizza tutti i preferiti",textAlign:TextAlign.right,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
            ),

          ]
        )
      );
    }
    else{
      return new Container(
        decoration: decFlipGrey(),
        height:50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        child: Center(
          child:new Text("Non ci sono preferiti",textAlign:TextAlign.center,style: TextStyle(color:Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
      );
    }

  }
  Container logo(){
    return new Container(
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
    );
  }
  Widget elenco(){
    return new GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
      },
      child: new Container(
        height:50,
        decoration: decFlip(),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children:[
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              child: new Text("Elenco anime",style: TextStyle(color:Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold))
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

  Widget login(){
    return new GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: new Container(
        height:50,
        decoration: decFlip(),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children:[
            Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                child: new Text("Effettua il login",style: TextStyle(color:Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold))
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
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 20.0),
            child: new Text("Visualizza attività precedenti",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }

  Widget albero(){
    return new FutureBuilder(
        future: Future.wait([ ApiService.getAnimeEvidenza(),ApiService.getAnimeSuggeriti(),ApiService.getToday(),this.getPreferiti()]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List ev = snapshot.data[0];
            List sug = snapshot.data[1];
            var today = snapshot.data[2];
            List pref = snapshot.data[3];

            return new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  children: [
                    ConnectionStatusBar(),
                    logo(),
                    preferiti(pref),
                    elenco(),
                    avanzata(),
                    testo("Evidenza"),
                    evidenza(ev),
                    testo("Suggeriti"),
                    suggeriti(sug),
                    activity(),
                    login(),
                    testo("Usciti oggi"),
                    grid(today['giorno']),
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