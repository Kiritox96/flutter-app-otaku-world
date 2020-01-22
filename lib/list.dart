import 'dart:io';
import 'package:flutter/material.dart';
import 'decoration.dart';
import 'rest_api.dart';
import 'anime.dart';

class ListPage extends StatefulWidget {
  const ListPage();
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  
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
            return new GridView.count(
              crossAxisCount: 3,
              children: List.generate(all.length, (index) {
                return Center(
                  child:GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
                    },
                    child: new Container(
                      decoration: DecorationService.dec(all[index]['image']),
                      width: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      
                    )
                  )
                );
              })
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
              return new GridView.count(
                crossAxisCount: 3,
                children: List.generate(all.length, (index) {
                  return Center(
                    child:GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
                      },
                      child: new Container(
                        decoration: DecorationService.dec(all[index]['image']),
                        width: MediaQuery.of(context).size.width / 4,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        
                      )
                    )
                  );
                })
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
