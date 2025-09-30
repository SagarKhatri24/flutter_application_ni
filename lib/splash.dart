import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_ni/bottomNav.dart';
import 'package:flutter_application_ni/constantData.dart';
import 'package:flutter_application_ni/jsonLogin.dart';
import 'package:flutter_application_ni/jsonProfile.dart';
import 'package:flutter_application_ni/jsonSignup.dart';
import 'package:flutter_application_ni/login.dart';
import 'package:flutter_application_ni/navigationDrawer.dart';
import 'package:flutter_application_ni/profile.dart';
import 'package:flutter_application_ni/razorpayDemo.dart';
import 'package:flutter_application_ni/signup.dart';
import 'package:flutter_application_ni/tabDemo.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var sp = await SharedPreferences.getInstance();
    var sUserId = sp.getString(ConstantData.USERID) ?? "";
    
    return new Timer(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> RazorpayPage() ));
      
      // if(sUserId == ""){
      //   //Navigator.push(context, MaterialPageRoute(builder: (_)=> TabApp() ));
      //   Navigator.push(context, MaterialPageRoute(builder: (_)=> JsonLoginApp() ));
      // }
      // else{
      //   Navigator.push(context, MaterialPageRoute(builder: (_)=> JsonProfileApp() ));        
      // }
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