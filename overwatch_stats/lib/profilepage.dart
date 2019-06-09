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
                  SizedBox(height: 50.0),
                  Image.network('${data["icon"]}'),
                  Text(
                    '${data["name"]}'.split("#")[0],
                    style: TextStyle(
                      fontFamily: 'BigNoodleToo',
                      fontSize: 80.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${data["gamesWon"]} Games Won',
                    style: TextStyle(
                      fontFamily: 'KOverwatch',
                      fontSize: 30.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 150.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Image.network('${data["levelIcon"]}',
                                  height: 150.0, width: 150.0),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${data["level"]}',
                                style: TextStyle(
                                  fontFamily: 'KOverwatch',
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                child:
                                    Image.network('${data["prestigeIcon"]}')),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: VerticalDivider(color: Colors.white),
                      ),
                      Column(
                        children: <Widget>[
                          Image.network('${data["ratingIcon"]}',
                              height: 150.0, width: 150.0),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    'Skill Rating ${data["rating"]} Points',
                    style: TextStyle(
                      fontFamily: 'KOverwatch',
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
