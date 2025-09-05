import 'package:flutter/material.dart';
import 'package:flutter_application_ni/SqliteHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupMain extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupApp(),
    );
  }

}

class SignupApp extends StatefulWidget{

  @override
  SignupState createState() => SignupState();

}

class SignupState extends State<SignupApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sName,sEmail,sContact,sPassword,sConfirmPassword;
  var dbHelper = SqliteHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
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
                        if(sPassword != sConfirmPassword){
                          Fluttertoast.showToast(
                            msg: "Password Does Not Match",
                            toastLength: Toast.LENGTH_SHORT
                            );
                        }
                        else{
                          insertData(sName,sEmail,sContact,sPassword);
                        }
                      }
                    }, 
                    child: Text("Insert")
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertData(sName,sEmail,sContact,sPassword) async{
    Map<String,dynamic> map = {
      SqliteHelper.name : sName,
      SqliteHelper.email : sEmail,
      SqliteHelper.contact : sContact,
      SqliteHelper.password : sPassword
    };

    final id = await dbHelper.insertFun(map);
    print(id);
    Fluttertoast.showToast(
      msg: "Insert Successfully",
      toastLength: Toast.LENGTH_SHORT
    );

  }

}