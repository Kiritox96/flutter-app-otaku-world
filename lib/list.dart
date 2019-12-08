import 'dart:io';

import 'package:flutter/material.dart';
import 'rest_api.dart';
import 'anime.dart';

class ListPage extends StatefulWidget {
  const ListPage();
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  BoxDecoration dec() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.white
    );
  }

  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = ""; // '$searchQuery' è la nostra variabile

  void _stopSearching() {
    this.setState(() {
      this._isSearching = false;
    });
  }
  void updateSearchQuery(String newQuery) {
    this.setState(() {
      this.searchQuery = newQuery;
    });
  }
  void _startSearch() {
    this.setState(() {
      _isSearching = true;
    });
  }
  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: _stopSearching,
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }
  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Esplora anime'),
          ],
        ),
      ),
    );
  }
  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Cerca per nome...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  Widget all(){
    if(this._isSearching ==false){
      return new FutureBuilder(
        future: Future.wait([ApiService.getAnimes()]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List all = snapshot.data[0];

            return new ListView.builder(
              itemCount: all.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
                  },
                  child: Container(
                    decoration:dec(),
                    margin:EdgeInsets.all(10.0),
                    width:MediaQuery.of(context).size.width,
                    height:100,
                    child: new Center(
                        child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[
                              new Container(
                                  decoration:new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                  height:100,
                                  width:100,
                                  child: new Image.network(all[index]['image'],width:100,height:100)
                              ),
                              new Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                      margin:EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
                                      height:30,
                                      width:MediaQuery.of(context).size.width-150,
                                      child: new Text(all[index]['name'], textAlign:TextAlign.left,style: new TextStyle(fontSize: 14.0, color: Colors.lightBlueAccent,fontWeight: FontWeight.bold))
                                  ),
                                  new Container(
                                      margin:EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
                                      height:30,
                                      width:MediaQuery.of(context).size.width-150,
                                      child: new Text("Episodi " + all[index]['episodi'].length.toString(), textAlign:TextAlign.left,style: new TextStyle(fontSize: 12.0, color: Colors.amber))
                                  )
                                ],
                              )
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(5.0),
                  ),
                );

              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      );
    }
    else if(this._isSearching == true && this.searchQuery != '' ){
      return new FutureBuilder(
          future: Future.wait([ApiService.searchAnimes(this.searchQuery)]),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List all = snapshot.data[0];
              print(snapshot.error);
              if(all.length > 0){
                return new ListView.builder(
                  itemCount: all.length,
                  itemBuilder: (BuildContext context, int index) {

                    return new Container(
                      decoration:dec(),
                      margin:EdgeInsets.all(10.0),
                      width:MediaQuery.of(context).size.width,
                      height:100,
                      child: new Center(
                          child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                new Container(
                                    decoration:new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                    height:100,
                                    width:100,
                                    child: new Image.network(all[index]['image'],width:100,height:100)
                                ),
                                new Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                        margin:EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
                                        height:30,
                                        width:MediaQuery.of(context).size.width-150,
                                        child: new Text(all[index]['name'], textAlign:TextAlign.left,style: new TextStyle(fontSize: 14.0, color: Colors.lightBlueAccent,fontWeight: FontWeight.bold))
                                    ),
                                    new Container(
                                        margin:EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
                                        height:30,
                                        width:MediaQuery.of(context).size.width-150,
                                        child: new Text("Episodi " + all[index]['episodi'].length.toString(), textAlign:TextAlign.left,style: new TextStyle(fontSize: 12.0, color: Colors.amber))
                                    )
                                  ],
                                )
                              ]
                          )
                      ),
                      padding: const EdgeInsets.all(5.0),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: all()
    );
  }
}
