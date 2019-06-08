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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text('${widget.battleTag}'.split('-')[0]),
      ),
      body: SafeArea(
        child: Center(child: ListView(padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Image.network('${data["ratingIcon"]}',height: 200.0, width: 200.0),
          SizedBox(height: 100.0),
          Center(child: Text("${data["name"]} your rank : ${data["rating"]}"))
        ],),
      ),)
    );
  }
}
