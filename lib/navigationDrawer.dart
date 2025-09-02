import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavigationMain extends StatefulWidget{

  @override
  NavigationApp createState() => NavigationApp();

}

class NavigationApp extends State<NavigationMain>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Navigation Drawer"),
          backgroundColor: Colors.amber.shade100,
        ),
        drawer: Drawer(
          child: new ListView(
            children: [
              UserAccountsDrawerHeader(                
                accountName: Text("John"), 
                accountEmail: Text("john@gmail.com"),
                currentAccountPicture: Icon(Icons.verified_user),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: (){
                  printMessage("Home");
                  //print("Home");
                },
              ),
              ListTile(
                title: Text("Orders"),
                trailing: Icon(Icons.chevron_right_outlined),
                leading: Icon(Icons.arrow_outward_rounded),
                onTap: (){
                  printMessage("Orders");
                  //print("Order");
                },
              ),
              ListTile(
                title: Text("Profile"),
                trailing: Icon(Icons.chevron_right_outlined),
                leading: Icon(Icons.person),
                onTap: (){
                  printMessage("Profile");
                  //print("Profile");
                },
              ),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.chevron_right_outlined),
                leading: Icon(Icons.logout),
                onTap: (){
                  printMessage("Logout");
                  //print("Logout");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  printMessage(var message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG
    );
  }

}