import 'package:flutter/material.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  BoxDecoration dec(String img) {
    return new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(img),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black45,
            offset: new Offset(5.0, 4.0),
            blurRadius: 2.0,
          )
        ],
        color: Colors.blueGrey
    );
  }
  Widget grid(List list){
    return new GridView.builder(
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (BuildContext context, int index){
        return Container(
          width: MediaQuery.of(context).size.width/2,
          margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 0, bottom: 10.0),
          decoration: dec(list[index]['image']),

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
    return new Scaffold(
        appBar: AppBar(
          title: Text("Calendario uscite"),
        ),
        body:grid(list)
    );
  }
}

