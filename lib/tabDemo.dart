import 'package:flutter/material.dart';
import 'package:flutter_application_ni/call.dart';
import 'package:flutter_application_ni/chat.dart';
import 'package:flutter_application_ni/status.dart';

class TabApp extends StatefulWidget{

  @override
  TabMain createState() => TabMain();

}

class TabMain extends State<TabApp> with SingleTickerProviderStateMixin{

  late TabController tabController;
  var tabArray = [ChatApp(),StatusApp(),CallApp()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tabArray.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tab Demo"),
          bottom: getTab(),
        ),
        body: getTabView()
      ),
    );
  }

  getTab(){
    return TabBar(
      tabs : [
        Tab(text: "Chat",),
        Tab(text: "Status",),
        Tab(text: "Call",)
      ],
      controller: tabController,
      unselectedLabelColor: Colors.black,
      labelColor: Colors.red,
      indicatorColor: Colors.deepPurple,
    );
  }

  getTabView(){
    return TabBarView(
      children: tabArray,
      controller: tabController,
    );
  }

}