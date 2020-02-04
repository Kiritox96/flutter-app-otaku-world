import 'package:flutter/material.dart';
import 'advanced_list.dart';
class RicercaPage extends StatefulWidget {
  @override
  _RicercaPageState createState() => _RicercaPageState();
}

class _RicercaPageState extends State<RicercaPage> {
  String txt = "";
  String _value = "1";
  String _valueGeneri = "Tutti";
  List<DropdownMenuItem<String>> generi() {
    var generi = [
      DropdownMenuItem<String>(
        value: "Tutti",
        child: Text("Tutti"),
      ),
      DropdownMenuItem<String>(
          value: "Arti Marziali",
          child: Text("Arti marziali")
      ),
      DropdownMenuItem<String>(
          value: "Avventura",
          child: Text("Avventura")
      ),
      DropdownMenuItem<String>(
          value: "Azione",
          child: Text("Azione")
      ),
      DropdownMenuItem<String>(
        value: "Bambini",
        child: Text("Bambini"),
      ),
      DropdownMenuItem<String>(
          value: "Commedia",
          child: Text("Commedia")
      ),
      DropdownMenuItem<String>(
          value: "Crimine",
          child: Text("Crimine")
      ),
      DropdownMenuItem<String>(
          value: "Demenziale",
          child: Text("Demenziale")
      ),
      DropdownMenuItem<String>(
        value: "Demoni",
        child: Text("Demoni"),
      ),
      DropdownMenuItem<String>(
          value: "Dramma",
          child: Text("Dramma")
      ),
      DropdownMenuItem<String>(
          value: "Ecchi",
          child: Text("Ecchi")
      ),
      DropdownMenuItem<String>(
          value: "Fantascienza",
          child: Text("Fantascienza")
      ),
      DropdownMenuItem<String>(
        value: "Fantasy",
        child: Text("Fantasy"),
      ),
      DropdownMenuItem<String>(
          value: "Giallo",
          child: Text("Giallo")
      ),
      DropdownMenuItem<String>(
          value: "Harem",
          child: Text("Harem")
      ),
      DropdownMenuItem<String>(
          value: "Hentai",
          child: Text("Hentai")
      ),
      DropdownMenuItem<String>(
        value: "Horror",
        child: Text("Horror"),
      ),
      DropdownMenuItem<String>(
          value: "Josei",
          child: Text("Josei")
      ),
      DropdownMenuItem<String>(
          value: "Magia",
          child: Text("Magia")
      ),
      DropdownMenuItem<String>(
          value: "Mecha",
          child: Text("Mecha")
      ),
      DropdownMenuItem<String>(
        value: "Militare",
        child: Text("Militare"),
      ),
      DropdownMenuItem<String>(
          value: "Mistero",
          child: Text("Mistero")
      ),
      DropdownMenuItem<String>(
          value: "Musica",
          child: Text("Musica")
      ),
      DropdownMenuItem<String>(
          value: "Parodia",
          child: Text("Parodia")
      ),
      DropdownMenuItem<String>(
        value: "Poliziesco",
        child: Text("Poliziesco"),
      ),
      DropdownMenuItem<String>(
          value: "Psicologico",
          child: Text("Psicologico")
      ),
      DropdownMenuItem<String>(
          value: "Samurai",
          child: Text("Samurai")
      ),
      DropdownMenuItem<String>(
          value: "Scuola",
          child: Text("Scuola")
      ),
      DropdownMenuItem<String>(
        value: "Seinen",
        child: Text("Seinen"),
      ),
      DropdownMenuItem<String>(
          value: "Sentimentale",
          child: Text("Sentimentale")
      ),
      DropdownMenuItem<String>(
          value: "Shojo",
          child: Text("Shojo")
      ),
      DropdownMenuItem<String>(
          value: "Shonen",
          child: Text("Shonen")
      ),
      DropdownMenuItem<String>(
        value: "Slice of life",
        child: Text("Slice of life"),
      ),
      DropdownMenuItem<String>(
          value: "Sovrannaturale",
          child: Text("Sovrannaturale")
      ),
      DropdownMenuItem<String>(
          value: "Spazio",
          child: Text("Spazio")
      ),
      DropdownMenuItem<String>(
          value: "Sport",
          child: Text("Sport")
      ),
      DropdownMenuItem<String>(
        value: "Storico",
        child: Text("Storico"),
      ),
      DropdownMenuItem<String>(
          value: "Superpoteri",
          child: Text("Superpoteri")
      ),
      DropdownMenuItem<String>(
          value: "Vampiri",
          child: Text("Vampiri")
      ),
      DropdownMenuItem<String>(
          value: "Videogame",
          child: Text("Videogame")
      ),
      DropdownMenuItem<String>(
          value: "Yaoi",
          child: Text("Yaoi")
      )
    ];
    return generi;
  }
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
      color: Colors.lightBlue
    );
  }
  BoxDecoration input() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Ricerca avanzata"),
      ),
      body: Center(
        child:Container(
          height: 550,
          decoration: dec() ,
          margin:EdgeInsets.all(10.0),
          width:MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Container(
                width:MediaQuery.of(context).size.width-30,
                margin:EdgeInsets.only(right: 10.0, left: 10.0, top: 25.0, bottom: 10.0),
                height:30,
                child: new Text("Nome",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
              ),
              Container(
                width:MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(10.0),
                decoration: input(),
                margin:EdgeInsets.all(10.0),
                child:TextField(
                  onChanged: (text){
                    setState(() {
                      this.txt = text;
                    });
                  }
                ),
              ),
              Container(
                width:MediaQuery.of(context).size.width-30,
                margin:EdgeInsets.all(10.0),
                height:30,
                child: new Text("Ordina per",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
              ),
              Container(
                width:MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(10.0),
                margin:EdgeInsets.all(10.0),
                decoration: input(),
                child: DropdownButton<String>(
                  items: [
                    DropdownMenuItem<String>(
                      value: "1",
                      child: Text("+ Episodi"),
                    ),
                    DropdownMenuItem<String>(
                      value: "2",
                      child: Text("- Episodi")
                    ),
                    DropdownMenuItem<String>(
                      value: "3",
                      child: Text("A-Z")
                    ),
                    DropdownMenuItem<String>(
                      value: "4",
                      child: Text("Z-A")
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  isExpanded: true,
                  value: _value,
                  elevation: 2,
                  isDense: true,
                  iconSize: 40.0
                )
              ),
              Container(
                width:MediaQuery.of(context).size.width-30,
                margin:EdgeInsets.all(10.0),
                height:30,
                child: new Text("Genere",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
              ),
              Container(
                width:MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(10.0),
                margin:EdgeInsets.all(10.0),
                decoration: input(),
                child: DropdownButton<String>(
                  items: generi(),
                  onChanged: (value) {
                    setState(() {
                      _valueGeneri = value;
                    });
                  },
                  isExpanded: true,
                  value: _valueGeneri,
                  elevation: 2,
                  isDense: true,
                  iconSize: 40.0
                )
              ),
              GestureDetector(
                  onTap: (){
                    String url = "/anime/anime?genere="+this._valueGeneri+"&order="+this._value+"&src="+this.txt;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListAdvancedPage(url:url)));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                      child: new Text("CERCA",textAlign:TextAlign.center,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))
                  )
              )

            ]
          ),
        )
      )
    );
  }
}

