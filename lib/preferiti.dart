import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'anime.dart';
import 'decoration.dart';

class PreferitiPage extends StatefulWidget {
  @override
  _PreferitiPageState createState() => _PreferitiPageState();
}

class _PreferitiPageState extends State<PreferitiPage> {


  Future<List<dynamic>> getPreferiti() async {
    var box = await Hive.openBox('animes');
    return box.values.toList();
  }
  Widget grid(){
    return new Container(
      height: MediaQuery.of(context).size.height,
      child: new FutureBuilder(
        future: Future.wait([this.getPreferiti()]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List preferiti = snapshot.data[0];
            if(preferiti.length > 0){
              return new GridView.count(
                crossAxisCount: 3,
                children: List.generate(preferiti.length, (index) {
                  return Center(
                    child:GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(preferiti[index])));
                      },
                      child: new Container(
                        decoration: DecorationService.dec(preferiti[index]['image']),
                        width: MediaQuery.of(context).size.width / 4,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        
                      )
                    )
                  );
                })
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

