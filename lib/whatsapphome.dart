import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'callscreen.dart';
import 'chatscreen.dart';
import 'statusscreen.dart';
import 'camerascreen.dart';

class WhatsApphome extends StatefulWidget {

  @override
  _WhatsApphomeState createState() => _WhatsApphomeState();
}

class _WhatsApphomeState extends State<WhatsApphome>
with SingleTickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState()
  {
    super.initState();
    _tabController=new TabController(
      length: 4, 
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WhatsApp"),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(icon:new Icon(Icons.camera_alt)),
            new Tab(text: "CHATS"),
            new Tab(text: "STATUS"),
            new Tab(text:"CALLS"),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search
            ),
            onPressed: (){
              showSearch(context: context, delegate: Datasearch());
            },
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          new IconButton(
            icon:new Icon(
              Icons.more_vert
            ),
            onPressed: (){},
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Camerascreen(),
          new Chatscreen(""),
          new Statuscreen(),
          new Callscreen(),
        ],
      ),
    );
  }
}

class Datasearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    
    return [
      new IconButton
      (
        icon: Icon
        (
          Icons.clear
        ), 
        onPressed: (){ query="";}
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return 
      new IconButton(
        icon: new AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, 
          progress: transitionAnimation,
        ), 
        onPressed: (){
          close(context, null);
        }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return Chatscreen(query);
  }

}