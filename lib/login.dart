import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}


class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  Animation<double> loginSize;
  AnimationController loginController;
  AnimatedOpacity opacityAnimation;
  Duration animationDuration = Duration(milliseconds: 270);
  String regPassword;
  String regConfirmPassword;
  String regEmail;
  String regUsername;
  String logEmail;
  String logPassword;
  @override
  void initState() {
    super.initState();
    loginController = AnimationController(vsync: this, duration: animationDuration);
    opacityAnimation = AnimatedOpacity(opacity: 0.0, duration: animationDuration);
  }

  BoxDecoration inputBianco() {
    return new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white
    );
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  Widget _buildLoginWidgets() {
    return Container(
      padding: EdgeInsets.only(bottom: 22, top: 5),
      width: MediaQuery.of(context).size.width,
      height: loginSize.value-100,
      decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(190), bottomRight: Radius.circular(190))),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          opacity: loginController.value,
          duration: animationDuration,
          child: GestureDetector(
            onTap: isLogin ? null : () {
              loginController.reverse();
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Container(
              child: Text('LOG IN'.toUpperCase(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginComponents() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Visibility(
          visible: isLogin,
          child: Padding(
            padding: const EdgeInsets.only(left: 42, right: 42),
            child: Column(
              children: <Widget>[
                Container(
                  width:MediaQuery.of(context).size.width-30,
                  padding: EdgeInsets.all(10.0),
                  decoration: inputBianco(),
                  margin:EdgeInsets.all(10.0),
                  child:TextField(
                      decoration: InputDecoration(prefixIcon: Icon(Icons.email), hintText: 'Email'),
                      onChanged: (text){
                        setState(() {
                          this.logEmail = text;
                        });
                      }
                  ),
                ),
                Container(
                  width:MediaQuery.of(context).size.width-30,
                  padding: EdgeInsets.all(10.0),
                  decoration: inputBianco(),
                  margin:EdgeInsets.all(10.0),
                  child:TextField(
                      decoration: InputDecoration(prefixIcon: Icon(Icons.vpn_key), hintText: 'Password'),
                      onChanged: (text){
                        setState(() {
                          this.logPassword = text;
                        });
                      }
                  ),
                ),
                Container(
                  width: 200,
                  height: 40,
                  margin: EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                    child: Text('LOG IN', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistercomponents() {
    return Padding(
      padding: EdgeInsets.only(left: 42, right: 42, top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('Sign Up'.toUpperCase(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
          ),
          Container(
            width:MediaQuery.of(context).size.width-30,
            padding: EdgeInsets.all(10.0),
            decoration: inputBianco(),
            margin:EdgeInsets.all(10.0),
            child:TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.email), hintText: 'Email'),
                onChanged: (text){
                  setState(() {
                    this.regEmail = text;
                  });
                }
            ),
          ),
          Container(
            width:MediaQuery.of(context).size.width-30,
            padding: EdgeInsets.all(10.0),
            decoration: inputBianco(),
            margin:EdgeInsets.all(10.0),
            child:TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.group), hintText: 'Username'),
                onChanged: (text){
                  setState(() {
                    this.regUsername = text;
                  });
                }
            ),
          ),
          Container(
            width:MediaQuery.of(context).size.width-30,
            padding: EdgeInsets.all(10.0),
            decoration: inputBianco(),
            margin:EdgeInsets.all(10.0),
            child:TextField(
              decoration: InputDecoration(prefixIcon: Icon(Icons.vpn_key), hintText: 'Password'),
              onChanged: (text){
                setState(() {
                  this.regPassword = text;
                });
              }
            ),
          ),
          Container(
            width:MediaQuery.of(context).size.width-30,
            padding: EdgeInsets.all(10.0),
            decoration: inputBianco(),
            margin:EdgeInsets.all(10.0),
            child:TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.vpn_key), hintText: 'Conferma password'),
                onChanged: (text){
                  setState(() {
                    this.regConfirmPassword = text;
                  });
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              width: 200,
              height: 40,
              margin: EdgeInsets.only(top: 32),
              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                child: Text('SIGN UP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ) ,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _defaultLoginSize = MediaQuery.of(context).size.height / 1.6;
    loginSize = Tween<double>(begin: _defaultLoginSize, end: 200).animate(CurvedAnimation(parent: loginController, curve: Curves.linear));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration,
              child: Container(child: _buildRegistercomponents()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: isLogin && !loginController.isAnimating ? Colors.white : Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: _defaultLoginSize/1.5,
              child: Visibility(
                visible: isLogin,
                child: GestureDetector(
                  onTap: () {
                    loginController.forward();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Center(
                    child: Text('Sign Up'.toUpperCase(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: loginController,
            builder: (context, child) {
              return _buildLoginWidgets();
            },
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                child: Center(child: _buildLoginComponents()),
              )
          )
        ],
      ),
    );
  }
}