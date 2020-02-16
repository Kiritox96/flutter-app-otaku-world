import 'package:flutter/material.dart';
import 'decoration.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivityPage extends StatefulWidget {

  @override
  _ActivityPageState createState() => new _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {



  Future<List<dynamic>> getActivity() async {
    var box = await Hive.openBox('activities');
    return box.values.toList();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Attività recenti")
        ),
        body: new FutureBuilder(
          future: Future.wait([this.getActivity()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData){
                List all = snapshot.data[0];
                if(all.length > 0){
                  return new ListView.builder(
                    itemCount: all.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new  Container(
                        decoration: DecorationService.decWhite(),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Container(
                            color: Colors.blue[200],
                            child: ListTile(
                             
                              title: Text(all[index]['anime']),
                              subtitle: Text("Visto episodio N° " + (int.parse(all[index]['episodio']) + 1).toString() ),
                            ),
                          ),
                        )
                      );
                    },
                  );
                }
                else{
                  return Center(
                    child: new Text("Non sono stati trovati risultati",textAlign:TextAlign.center,style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold)),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        )
    );
  }
}

