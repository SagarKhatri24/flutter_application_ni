import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ni/SqliteHelper.dart';
import 'package:flutter_application_ni/jsonSignup.dart';
import 'package:flutter_application_ni/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class JsonLoginApp extends StatefulWidget{

  @override
  JsonLoginState createState() => JsonLoginState();

}

class JsonLoginState extends State<JsonLoginApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sEmail,sPassword;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Email",
                    hintText: "Enter Email Id",
                  ),
                  onSaved: (value){
                    sEmail = value!;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return "Email Id Required";
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Password",
                    hintText: "Enter Password",
                  ),
                  onSaved: (value){
                    sPassword = value!;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return "Password Required";
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  color: Colors.blue.shade300,
                  width: 200.0,
                  height: 40.0,
                  child: TextButton(
                    onPressed: () async {
                      var connection = await Connectivity().checkConnectivity();
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                          if (connection.contains(ConnectivityResult.mobile) || connection.contains(ConnectivityResult.wifi)){
                            //insertData(sEmail,sPassword);
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: "Internet/Wifi Not Connected",
                              toastLength: Toast.LENGTH_SHORT
                            );
                          }
                          //insertData(sName,sEmail,sContact,sPassword);
                        
                      }
                      
                    }, 
                    child: Text("Login")
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  color: Colors.blue.shade300,
                  width: 300.0,
                  height: 40.0,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>JsonSignupApp()));
                    }, 
                    child: Text("Create An Account")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertData(sEmail,sPassword) async{
    var map = {
        'email' : sEmail,
        'password' : sPassword
      };

    var data = await http.post(Uri.parse('http://localhost/ni_api/signup.php'),body: map);
    if(data.statusCode == 200){
      var jsonData = json.decode(data.body);
      if(jsonData["status"] == true){
        Fluttertoast.showToast(
          msg: jsonData["message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );
        Navigator.pop(context);
      }
      else{
        Fluttertoast.showToast(
          msg: jsonData["message"],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0
        );
      }
    }
    else{
      Fluttertoast.showToast(
        msg: "Server Error Code : ${data.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0
      );
    }

  }

}