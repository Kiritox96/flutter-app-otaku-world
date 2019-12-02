import 'package:flutter/material.dart';
import 'rest_api.dart';
import 'package:page_indicator/page_indicator.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  final PageController controller = new PageController();
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
  Widget giorno(String txt,List list,double width,double height){
    return new Container(
      child:Column(
        children:[
          Container(
            width: width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
            child: new Text(txt,textAlign:TextAlign.center,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
          ),
          Container(
            height: height-160,
            width: width,
            margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 0),
            child: grid(list)
          ),
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Calendario uscite"),
        ),
        body: new FutureBuilder(
          future: Future.wait([ApiService.getCalendario()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData){
                List all = snapshot.data;
                return new PageIndicatorContainer(
                  child: PageView(
                    children: [
                      giorno("Lunedi",all[0]['lunedi'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Martedi",all[0]['martedi'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Mercoledi",all[0]['mercoledi'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Giovedi",all[0]['giovedi'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Venerdi",all[0]['venerdi'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Sabato",all[0]['sabato'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height),
                      giorno("Domenica",all[0]['domenica'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height)
                    ],
                    controller: controller,
                  ),
                  align: IndicatorAlign.bottom,
                  length: 7,
                  indicatorSpace: 10.0,
                  padding: const EdgeInsets.all(10),
                  indicatorColor: Colors.black,
                  indicatorSelectorColor: Colors.red,
                  shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
                );
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

