import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import 'rest_api.dart';
class CapitoloPage extends StatefulWidget {
  final String id;
  
  CapitoloPage(String id): this.id = id;
  @override
  _CapitoloPageState createState() => new _CapitoloPageState(id);
}

class _CapitoloPageState extends State<CapitoloPage> {

  String id;
  _CapitoloPageState(this.id);
  
  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(
        title: Text("Indietro"),
      ),
      body: new FutureBuilder(
        future: Future.wait([ApiService.getCapitolo(this.id)]),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List caps = snapshot.data[0]['images'];
            print(caps);
            List<StoryItem> capitoli = [];
            caps.forEach((cap) => capitoli.add(
              StoryItem.pageImage(
                NetworkImage('https://cdn.mangaeden.com/mangasimg/' + cap[1]),
                caption: 'Pagina N°' + (caps.length-cap[0]).toString(),
              )
            ));
            return new  Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(color: Colors.black),
              height: MediaQuery.of(context).size.height,
              child: StoryView(
                capitoli,
                onStoryShow: (s) {print("Showing a story");},
                onComplete: () {print("Completed a cycle");},
                progressPosition: ProgressPosition.bottom,
                repeat: false,
                inline: true,
              )
            );
          } else {
            return Center(
              child:CircularProgressIndicator()
            );
          }
        }
      )
    );
  }
}