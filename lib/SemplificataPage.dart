import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/calendario.dart';
import 'package:hello/home.dart';
import 'package:hello/ricerca.dart';
import 'list.dart';
import 'preferiti.dart';
import 'package:connection_status_bar/connection_status_bar.dart';

class SemplificataPage extends StatefulWidget {
  @override
  _SemplificataPageState createState() => _SemplificataPageState();
}


class _SemplificataPageState extends State<SemplificataPage> {
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

  Widget elenco() {
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
        },
        child: new Container(
            height: 50,
            decoration: decFlip(),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: new Text("Elenco anime", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold))
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

  Widget calendario() {
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarioPage()));
        },
        child: new Container(
            height: 50,
            decoration: decFlip(),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: new Text("Calendario", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold))
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
  Widget preferiti() {
    return new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PreferitiPage()));
        },
        child: new Container(
            height: 50,
            decoration: decFlip(),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: new Text("Preferiti", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold))
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
  Widget avanzata(){
    return new  GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => RicercaPage()));
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 30),
            child: new Text("Ricerca avanzata",textAlign:TextAlign.right,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }

  Container logo() {
    return new Container(
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 0),
        width: MediaQuery.of(context).size.width,
        color: Color(0x060606),
        height: 210,
        child: Column(
            children: [
              Image.asset("logo.png"),
              Divider(height: 2, color: Colors.black)
            ]
        )
    );
  }
  Widget home(){
    return new GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 0),
          child: new Text("Passa alla versione normale",textAlign:TextAlign.center,style: TextStyle(color:Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.bold))
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,

        body: new Container(
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: new Column(
                        children: [
                          ConnectionStatusBar(),
                          logo(),
                          elenco(),
                          avanzata(),
                          calendario(),
                          preferiti(),
                          home()
                        ]
                    )
                )
            )
        )
    );
  }
}
