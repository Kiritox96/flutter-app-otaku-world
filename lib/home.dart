import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hello/login.dart';
import 'package:hello/ricerca.dart';
import 'rest_api.dart';
import 'calendario.dart';
import 'list.dart';
import 'ricerca.dart';
import 'login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
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
  Widget evidenza(List cans) {
    return new CarouselSlider(
      height: 175.0,
      items: cans.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
              decoration: dec(i['image']),
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
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
              decoration: dec(i['image']),

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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: dec(today[0]['image']),
                    width: (x/2)-20,
                    height: 150,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: dec(today[1]['image']),
                    width: (x/2)-20,
                    height: 150,
                  )
                ]
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: dec(today[2]['image']),
                    width: (x/2)-20,
                    height: 150,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: dec(today[3]['image']),
                    width: (x/2)-20,
                    height: 150,
                  ),

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
  Container flipCard() {
    return new Container(
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: new FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          decoration: decFlip(),
          child: Center(child: new Text("Scopri il nostro repertorio di anime", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center))
        ),
        back: Container(
          decoration: decFlip(),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      margin: EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                        top: 10.0,
                        bottom: 0
                      ),


                    )


                  ]
                )
              )
            )

          ),
        )
      )
    );
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
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new FutureBuilder(
        future: Future.wait([ ApiService.getAnimeEvidenza(),ApiService.getAnimeSuggeriti(),ApiService.getToday()]),
        builder: (context, snapshot) {
          print(snapshot.error);
          if (snapshot.hasData) {
            //Filter anime evidenza
            List ev = snapshot.data[0];
            List sug = snapshot.data[1];
            var today = snapshot.data[2];
            return new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  children: [
                    ConnectionStatusBar(),
                    logo(),
                    elenco(),
                    avanzata(),
                    testo("Evidenza"),
                    evidenza(ev),
                    testo("Suggeriti"),
                    suggeriti(sug),
                    login(),
                    testo("Usciti oggi"),
                    grid(today['giorno'])
                  ]
                )
              )
            );

          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      )

    );
  }
}