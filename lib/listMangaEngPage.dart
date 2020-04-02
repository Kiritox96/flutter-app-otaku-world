import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';
import 'decoration.dart';
import 'rest_api.dart';
import 'manga.dart';

class ListMangaEngPage extends StatefulWidget {
  const ListMangaEngPage();
  @override
  _ListMangaEngPageState createState() => new _ListMangaEngPageState();
}

class _ListMangaEngPageState extends State<ListMangaEngPage> with UnityAdsListener{
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = ""; // '$searchQuery' è la nostra variabile

  String videoPlacementId='video';
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  dynamic link;
  dynamic link2;
  void _stopSearching() {
    setState(() {
      _isSearching = false;
    });
  }
  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }
  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }
   @override
  initState() {
    UnityAdsFlutter.initialize(gameIdAndroid, gameIdIOS, this, true);
    Timer(Duration(seconds: 10), () {
      UnityAdsFlutter.show('video');
    });
    
    super.initState();
  }
  @override
  void onUnityAdsError(UnityAdsError error, String message) {
    print('$error occurred: $message');
  }

  @override
  void onUnityAdsFinish(String placementId, FinishState result) {
    print('Finished $placementId with $result');
  }

  @override
  void onUnityAdsReady(String placementId) {
    print('Ready: $placementId');
  }

  @override
  void onUnityAdsStart(String placementId) {
    print('Start: $placementId');
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
            const Text('Esplora manga'),
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
        future: Future.wait([ApiService.getMangas('0')]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List all = snapshot.data[0]['manga'];
            all.removeWhere((manga) => manga['im'] == null);
            all.sort((a, b) => a['t'].compareTo(b['t']));
            return new GridView.count(
              crossAxisCount: 2,
              children: List.generate(all.length, (index) {
                return Center(
                  child:GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MangaPage(all[index]['i'], all[index]['t'])));
                    },
                    child: Container(
                      decoration: DecorationService.decEvidenza(),
                      height: MediaQuery.of(context).size.width / 2,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child:Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                            width:150,
                            height: 100,
                            decoration: DecorationService.decNoShadow('https://cdn.mangaeden.com/mangasimg/' + all[index]['im']),
                          )),
                          Expanded(child:Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: new Text(all[index]['t'], textAlign: TextAlign.center,),
                          ))
                        ],
                      )
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
        future: Future.wait([ApiService.getMangas('0')]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List all = snapshot.data[0]['manga'];
            all.removeWhere((manga) => manga['im'] == null);
            print(all.length);
            List all2 = all.where((manga) => manga['t'].toString().toLowerCase().contains(this.searchQuery.toLowerCase())).toList();
            print(all2.length);
            all2.sort((a, b) => a['t'].compareTo(b['t']));
            if(all2.length > 0){
              return new GridView.count(
                crossAxisCount: 2,
                children: List.generate(all2.length, (index) {
                  return Center(
                    child:GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MangaPage(all2[index]['i'], all2[index]['t'])));
                      },
                      child: Container(
                        decoration: DecorationService.decEvidenza(),
                        height: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child:Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                              width:150,
                              height: 100,
                              decoration: DecorationService.decNoShadow('https://cdn.mangaeden.com/mangasimg/' + all2[index]['im']),
                            )),
                            Expanded(child:Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: new Text(all2[index]['t'], textAlign: TextAlign.center,),
                            ))
                          
                          ],
                        )
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
