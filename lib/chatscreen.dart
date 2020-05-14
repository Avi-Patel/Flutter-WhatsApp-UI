import 'package:flutter/material.dart';
import 'Models/chat_model.dart';

class Chatscreen extends StatefulWidget {

  String query;
  Chatscreen(this.query);

  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: ()=> print("Open chats"),
      ),
      body:ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context,index)=> widget.query==null? new Column(
          children: <Widget>[
            index!=0? new Divider(
            height: 5.0,
            ):new Container(),
            new ListTile(
              leading: new CircleAvatar(
                radius: 25.0,
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: new NetworkImage(
                  dummyData[index].avatarUrl,
                ),
                
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    dummyData[index].name,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  new Text(
                    dummyData[index].time,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),

              subtitle: new Container(
                padding: const EdgeInsets.only(top:5.0),
                child: new Text( 
                  dummyData[index].message,
                  style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        )
        :
        dummyData[index].name.toLowerCase().contains(widget.query.toLowerCase())? new Column(
          children: <Widget>[
            index!=0? new Divider(
            height: 5.0,
            ):new Container(),
            new ListTile(
              leading: new CircleAvatar(
                radius: 25.0,
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: new NetworkImage(
                  dummyData[index].avatarUrl,
                ),
                
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    dummyData[index].name,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  new Text(
                    dummyData[index].time,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),

              subtitle: new Container(
                padding: const EdgeInsets.only(top:5.0),
                child: new Text( 
                  dummyData[index].message,
                  style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ): new Container(),
      ),
    );
  }
}