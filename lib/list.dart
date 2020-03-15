import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unity_ads_flutter/unity_ads_flutter.dart';
import 'decoration.dart';
import 'rest_api.dart';
import 'anime.dart';

class ListPage extends StatefulWidget {
  const ListPage();
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> with UnityAdsListener {
  Timer timer;
  String videoPlacementId='video';
  String gameIdAndroid='3427627';
  String gameIdIOS='3427626';
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  bool _isSearching = false;
  int tim;
  String searchQuery = ""; // '$searchQuery' è la nostra variabile
  @override
  initState() {
    UnityAdsFlutter.initialize(gameIdAndroid, gameIdIOS, this, true);
    this.tim = 15;
    timer = Timer.periodic(Duration(seconds: this.tim), (Timer t) =>{
      setState(()=>this.tim = this.tim +30),
      print(this.tim),
      UnityAdsFlutter.show('video')
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
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget all(){
    if(this._isSearching ==false){
      return new FutureBuilder(
        future: Future.wait([ApiService.getAnimes()]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List all = snapshot.data[0];
            return new GridView.count(
              crossAxisCount: 2,
              children: List.generate(all.length, (index) {
                return Center(
                  child:GestureDetector(
                    onTap: (){                      
                      timer?.cancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
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
                            decoration: DecorationService.decNoShadow(all[index]['image']),
                          )),
                          Expanded(child:Container(
                            margin: EdgeInsets.only(right: 10.0, left: 10.0),
                            child: new Text(all[index]['name'], textAlign: TextAlign.center,),
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
        future: Future.wait([ApiService.searchAnimes(this.searchQuery)]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List all = snapshot.data[0];
            print(snapshot.error);
            if(all.length > 0){
              return new GridView.count(
                crossAxisCount: 2,
                children: List.generate(all.length, (index) {
                  return Center(
                    child:GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimePage(all[index])));
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
                              decoration: DecorationService.decNoShadow(all[index]['image']),
                            )),
                            Expanded(child:Container(
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: new Text(all[index]['name'], textAlign: TextAlign.center,),
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
