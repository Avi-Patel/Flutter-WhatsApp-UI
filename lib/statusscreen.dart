import 'package:flutter/material.dart';

class Statuscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(
            Icons.camera,
            color: Colors.white,
          ),
          onPressed: ()=> print("Open chats"),
      ),
      body: Center(
        child: new Text(
          "Status",
          style: new TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}