import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_ni/tabDemo.dart';

class SplashMain extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashApp(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class SplashApp extends StatefulWidget{

  @override
  SplashDemo createState() => SplashDemo();

}

class SplashDemo extends State<SplashApp>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  Future<Timer> startTimer() async{
    return new Timer(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> TabApp() ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
      ),
      body: Container(
        color: Colors.deepOrange.shade50,
        child: Center(
          child: Image.asset('assets/images/icon.png', width: 150.0, height: 150.0,),
        ),
      ),
    );
  }

}