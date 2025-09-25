import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ni/SqliteHelper.dart';
import 'package:flutter_application_ni/constantData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JsonProfileApp extends StatefulWidget{

  @override
  JsonProfileState createState() => JsonProfileState();

}

class JsonProfileState extends State<JsonProfileApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sUserId,sName,sEmail,sContact,sPassword,sConfirmPassword;
  int iGroupValue = 3;
  List<String> cityArray = [
    'Ahmedabad',
    'Vadodara',
    'Surat',
    'Rajkot'
  ];

  late String sCity = "Ahmedabad";
  late String sGender = "Male";

  var nameController,emailController,contactController;
  var sp;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  setData() async{
    sp = await SharedPreferences.getInstance();
    setState(() {
      sUserId = sp.getString(ConstantData.USERID) ?? "";
      sName = sp.getString(ConstantData.NAME) ?? "";
      sEmail = sp.getString(ConstantData.EMAIL) ?? "";
      sContact = sp.getString(ConstantData.CONTACT) ?? "";
      sCity = sp.getString(ConstantData.CITY) ?? "Ahmedabad";
      sGender = sp.getString(ConstantData.GENDER) ?? "Male";
      if(sGender == "Male"){
        iGroupValue = 0;
      }
      else if(sGender == "Female"){
        iGroupValue = 1;
      }
      else if(sGender == "Transgender"){
        iGroupValue = 2;
      }
      else{
        iGroupValue = 3;
      }

      nameController = TextEditingController(text: sName);
      emailController = TextEditingController(text: sEmail);
      contactController = TextEditingController(text: sContact);
      


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Name",
                    hintText: "Enter Name",
                  ),
                  onSaved: (value){
                    sName = value!;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return "Name Required";
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
                  controller: emailController,
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
                  controller: contactController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Contact No.",
                    hintText: "Enter Contact No.",
                  ),
                  onSaved: (value){
                    sContact = value!;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return "Contact No. Required";
                    }
                    else if(value.length<10){
                      return "Valid Contact No. Required";
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Confirm Password",
                    hintText: "Enter Confirm Password",
                  ),
                  onSaved: (value){
                    sConfirmPassword = value!;
                  },
                  validator: (value){
                    if (value!.isEmpty){
                      return "Confirm Password Required";
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: 0, 
                          groupValue: iGroupValue, 
                          onChanged: (value){
                            setState(() {
                              setGender(value,"Male");  
                            });
                          }
                        ),
                        Text("Male",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: 1, 
                          groupValue: iGroupValue, 
                          onChanged: (value){
                            setState(() {
                              setGender(value,"Female");  
                            });
                          }
                        ),
                        Text("Female",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: 2, 
                          groupValue: iGroupValue, 
                          onChanged: (value){
                            setState(() {
                              setGender(value,"Transgender");  
                            });
                          }
                        ),
                        Text("Transgender",style: TextStyle(color: Colors.black,fontSize: 15.0),),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    DropdownButton(
                      items : cityArray.map((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                          );
                      }).toList(), 
                      value: sCity,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      onChanged: (data){
                        setState(() {
                          sCity = data as String;
                        });
                      }
                    ),
                  ],
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
                        if(sPassword != sConfirmPassword){
                          Fluttertoast.showToast(
                            msg: "Password Does Not Match",
                            toastLength: Toast.LENGTH_SHORT
                            );
                        }
                        else{
                          if (connection.contains(ConnectivityResult.mobile) || connection.contains(ConnectivityResult.wifi)){
                            insertData(sUserId,sName,sEmail,sContact,sPassword,sGender,sCity);
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: "Internet/Wifi Not Connected",
                              toastLength: Toast.LENGTH_SHORT
                            );
                          }
                          //insertData(sName,sEmail,sContact,sPassword);
                        }
                      }
                      
                    }, 
                    child: Text("Update Profile")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setGender(value,message){
    iGroupValue = value;
    sGender = message;
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.amber,
      textColor: Colors.black,
      fontSize: 16.0
    );
  }

  void insertData(sUserId,sName,sEmail,sContact,sPassword,sGender,sCity) async{
    var map = {
        'userid' : sUserId,
        'app_name' : sName,
        'email' : sEmail,
        'contact' : sContact,
        'password' : sPassword,
        'gender' : sGender,
        'city' : sCity
      };

    var data = await http.post(Uri.parse(ConstantData.BASE_URL+'updateProfile.php'),body: map);
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

        sp.setString(ConstantData.USERID, sUserId);
        sp.setString(ConstantData.NAME, sName);
        sp.setString(ConstantData.EMAIL, sEmail);
        sp.setString(ConstantData.CONTACT, sContact);
        sp.setString(ConstantData.CITY, sCity);
        sp.setString(ConstantData.GENDER, sGender);
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