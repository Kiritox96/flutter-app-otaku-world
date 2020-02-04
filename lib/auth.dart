import 'dart:convert';

import 'package:OtakuWorld/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post("http://otaku-world.space:3000/auth/login", body: {
      "password": password,
      "email": email
    });
    final data = jsonDecode(response.body);
    String message = data['message'];
    if (message == "Login Successful") {

      setState(() {
        _loginStatus = LoginStatus.signIn;
      });
      var box = await Hive.openBox("user");

      box.put('email', email);

      _showDialog("Il login ha avuto successo", "Login effettuato");
    } else {
      _showDialog("Il login non è andato a buon fine", "Login errato");
    }
  }



  getPref() async {
    var box = await Hive.openBox("user");
    var em = box.get('email');  
    setState(() {
      _loginStatus = em != null ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    var box = await Hive.openBox("user");
    box.put('email', null);    
    setState(() {
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }
  void _showDialog(String txt, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(txt),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Chiudi"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute( builder: (context) => HomePage()));
            },
            child: Icon(Icons.home),
            backgroundColor: Colors.orange[200],
          ),
          backgroundColor: Colors.blue[200],
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue[200],
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("logo.png"),
                          SizedBox(height: 40),
                          SizedBox(height: 50,child: Text("Login",style: TextStyle(color: Colors.white, fontSize: 30.0))),
                          SizedBox(height: 25),
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Inserisci email";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Padding(padding:EdgeInsets.only(left: 20, right: 15),
                                child:Icon(Icons.person, color: Colors.black) ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Email"
                              ),
                            ),
                          ),

                          // Card for password TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Inserisci password";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.phonelink_lock,color: Colors.black),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText? Icons.visibility_off: Icons.visibility),
                                ),
                                contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 44.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),
                                  child: Text( "Login",style: TextStyle(fontSize: 18.0)),
                                  textColor: Colors.white,
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    check();
                                  }
                                ),
                              ),
                              SizedBox(
                                height: 44.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0)),
                                  child: Text("Vuoi registrarti?",style: TextStyle(fontSize: 18.0)),
                                  textColor: Colors.white,
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute( builder: (context) => Register()));
                                  }
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return ProfilePage(signOut);
        break;
    }
  }
}
class ProfilePage extends StatefulWidget {
  final dynamic signOut;
  ProfilePage(dynamic signOut): this.signOut = signOut;

  @override
  _ProfileState createState() => _ProfileState(this.signOut);
}
class _ProfileState extends State<ProfilePage> {
  _ProfileState(this.signOut);
  final dynamic signOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute( builder: (context) => HomePage()));
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.orange[200],
      ),
      body: Center(
        child: new FlatButton(
          child: new Text("LOGOUT"),
          onPressed: () {
            signOut();
          },
        ),
      ),
    );
  }
}



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;
  void _showDialog(String txt, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(txt),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Chiudi"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      if(password.length < 10){
        _showDialog("La password è troppo corta", "Password errata");
      } 
      else{
        save();
      }
    }
  }

  save() async {
    final response = await http.post("http://otaku-world.space:3000/auth/register", body: {
      "name": name,
      "email": email,
      "password": password,
    });

    final data = jsonDecode(response.body);
    String message = data['message'];
    if (message == 'User created successfully') {
      _showDialog("La registrazione è andata a buon fine", "Registrazione effettuata");
    } else {
      _showDialog("Registrazione fallita.", "E' possibile che ci sia un utente già registrato con questa email.");
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute( builder: (context) => HomePage()));
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.orange[200],
      ),
      backgroundColor: Colors.blue[200],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue[200],
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("logo.png"),
                      SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        child: Text("Registrazione",style: TextStyle(color: Colors.white, fontSize: 30.0)),
                      ),
                      SizedBox(height: 25),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Inserisci username";
                            }
                          },
                          onSaved: (e) => name = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(padding: EdgeInsets.only(left: 20, right: 15),child: Icon(Icons.person, color: Colors.black)),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Username"
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Inserisci email";
                            }
                          },
                          onSaved: (e) => email = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.email, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText? Icons.visibility_off: Icons.visibility),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phonelink_lock, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Password"
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(25.0)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              child: Text("Registrati",style: TextStyle(fontSize: 18.0)),
                              textColor: Colors.white,
                              color: Colors.blue[300],
                              onPressed: () {
                                check();
                              }
                            ),
                          ),
                          SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              child: Text("Sei già registrato?",style: TextStyle(fontSize: 18.0)),
                              textColor: Colors.white,
                              color: Colors.blue[300],
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


