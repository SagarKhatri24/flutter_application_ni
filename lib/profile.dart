import 'package:flutter/material.dart';
import 'package:flutter_application_ni/SqliteHelper.dart';
import 'package:flutter_application_ni/constantData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApp extends StatefulWidget{

  @override
  ProfileState createState() => ProfileState();

}

class ProfileState extends State<ProfileApp>{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  late String sUserId,sName,sEmail,sContact,sPassword,sConfirmPassword;
  var dbHelper = SqliteHelper();
  var sp;

  var nameController,emailController,contactController,passwordController,confirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionData();
  }

  getSessionData() async{
    sp = await SharedPreferences.getInstance();
    setState(() {
      sUserId = sp.getString(ConstantData.USERID) ?? "";
      sName = sp.getString(ConstantData.NAME) ?? "";
      sEmail = sp.getString(ConstantData.EMAIL) ?? "";
      sContact = sp.getString(ConstantData.CONTACT) ?? "";
      sPassword = sp.getString(ConstantData.PASSWORD) ?? "";
      sConfirmPassword = sp.getString(ConstantData.PASSWORD) ?? "";

      nameController = TextEditingController(text: sName);
      emailController = TextEditingController(text: sEmail);
      contactController = TextEditingController(text: sContact);
      passwordController = TextEditingController(text: sPassword);
      confirmPasswordController = TextEditingController(text: sConfirmPassword);

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
                  controller: passwordController,
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
                  controller: confirmPasswordController,
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
                          updateData(sUserId,sName,sEmail,sContact,sPassword);
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

  void updateData(String sUserId,String sName,String sEmail,String sContact,String sPassword) async{
    var sp = await SharedPreferences.getInstance();
    
    Map<String,dynamic> map = {
      SqliteHelper.name : sName,
      SqliteHelper.email : sEmail,
      SqliteHelper.contact : sContact,
      SqliteHelper.password : sPassword
    };
    final id = await dbHelper.updateFun(map,sUserId);
    print(id);
    Fluttertoast.showToast(
      msg: "Profile Update Successfully",
      toastLength: Toast.LENGTH_SHORT
    );

    sp.setString(ConstantData.NAME, sName);
    sp.setString(ConstantData.EMAIL, sEmail);
    sp.setString(ConstantData.CONTACT, sContact);
    sp.setString(ConstantData.PASSWORD, sPassword);

  }

}