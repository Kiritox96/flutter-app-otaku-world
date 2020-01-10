import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'decoration.dart';
import 'rest_api.dart';
import 'anime.dart';

class ListAdvancedPage extends StatefulWidget {
  final String url;
  ListAdvancedPage({
    String url
  }): this.url = url;
  @override
  _ListAdvancedPageState createState() => new _ListAdvancedPageState(url);
}

class _ListAdvancedPageState extends State<ListAdvancedPage> {

  _ListAdvancedPageState(this.url);
  final String url;

  
  void putActivity(dynamic anime) async {
    var box = await Hive.openBox('activities');
    box.add(anime);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Esplora anime")
      ),
      body: new FutureBuilder(
        future: Future.wait([ApiService.getAdvancedSearch(this.url)]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              List all = snapshot.data[0];
              if(all.length > 0){
                return new ListView.builder(
                  itemCount: all.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
                      },
                      child: Container(
                        height: 175,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        decoration: DecorationService.dec(all[index]['image']),

                      ),
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
