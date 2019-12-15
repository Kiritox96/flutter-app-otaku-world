import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'anime.dart';

class PreferitiPage extends StatefulWidget {
  @override
  _PreferitiPageState createState() => _PreferitiPageState();
}

class _PreferitiPageState extends State<PreferitiPage> {


  Future<List<dynamic>> getPreferiti() async {
    var box = await Hive.openBox('animes');
    return box.values.toList();
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
  Widget grid(){
    return new Container(
        child: new FutureBuilder(
            future: Future.wait([this.getPreferiti()]),
            builder: (context, snapshot) {
              print(snapshot.error);
              if (snapshot.hasData) {
                //Filter anime evidenza
                List preferiti = snapshot.data[0];
                if(preferiti.length > 0){
                  return new ListView.builder(
                    itemCount: preferiti.length,
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[index])));
                          },
                          child: new Container(
                            height:35,
                            decoration: decFlip(),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                            child: Container(
                              margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0, bottom: 5.0),
                              child: new Text(preferiti[index]['name'],style: TextStyle(color:Colors.white,fontSize: 15.0))
                            )


                          )
                      );
                    },
                  );
                }
                return new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                    child: new Text("Nessun anime è stato salvato tra i preferiti",textAlign:TextAlign.center,style: TextStyle(color:Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold))
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        )

    );


  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Text("Preferiti"),
        ),
        body:grid()
    );
  }
}

