import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String region;
  final String battleTag;

  ProfilePage({Key key, this.region, this.battleTag}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // gets overwatch api
  Map<String, dynamic> data;

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://ow-api.com/v1/stats/pc/${widget.region}/${widget.battleTag}/profile"),
        headers: {"Accept": "application/json"});

    print(response.statusCode);

    this.setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    while (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Image.asset('assets/images/overwatch_logo.png',
            height: 50.0, width: 50.0),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/overwatch_gibraltar_blur.png"),
              fit: BoxFit.none,
              alignment: Alignment(0.5, -0.5)),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network('${data["icon"]}', height: 200.0, width: 200.0),
                  Text(
                    '${data["name"]}'.split("#")[0],
                    style: TextStyle(
                      fontFamily: 'BigNoodleToo',
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${data["gamesWon"]} Games Won',
                    style: TextStyle(
                      fontFamily: 'KOverwatch',
                      fontSize: 20.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.network('${data["levelIcon"]}', height: 100.0, width: 100.0),
                    //Image.network('${data["endorsementIcon"]}', height: 50.0, width: 50.0),
                    Image.network('${data["ratingIcon"]}', height: 100.0, width: 100.0),
                  ],)




















                  Center(
                    child: Text(
                      "${data["name"]} your rank : ${data["rating"]}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
