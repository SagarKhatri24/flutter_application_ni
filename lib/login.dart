import 'package:flutter/material.dart';
import 'package:flutter_application_ni/SqliteHelper.dart';
import 'package:flutter_application_ni/constantData.dart';
import 'package:flutter_application_ni/profile.dart';
import 'package:flutter_application_ni/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMain extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginApp(),
    );
  }

}

class LoginApp extends StatefulWidget{

  @override
  LoginState createState() => LoginState();

}

class LoginState extends State<LoginApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sEmail,sPassword;
  var dbHelper = SqliteHelper();

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
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                          loginData(sEmail,sPassword);
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
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupApp()));
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

  void loginData(sEmail,sPassword) async{
    var sp = await SharedPreferences.getInstance();
    var listData = await dbHelper.loginData(sEmail, sPassword);
    if(listData.length > 0){
      print(listData);
      print(listData.length);
      
      var sUserId = listData[0]['userId'];
      var sName = listData[0]['name'];
      var sEmail = listData[0]['email'];
      var sContact = listData[0]['contact'];
      var sPassword = listData[0]['password'];
      
      print(sUserId);
      print(sName);
      print(sEmail);
      print(sContact);
      print(sPassword);

      sp.setString(ConstantData.USERID, sUserId.toString());
      sp.setString(ConstantData.NAME, sName);
      sp.setString(ConstantData.EMAIL, sEmail);
      sp.setString(ConstantData.CONTACT, sContact);
      sp.setString(ConstantData.PASSWORD, sPassword);

      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT
      );

      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileApp()));

    }
    else{      
      Fluttertoast.showToast(
        msg: "Login Unsuccessfully",
        toastLength: Toast.LENGTH_SHORT
      );
    }
  }

}