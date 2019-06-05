import 'package:flutter/material.dart';
import 'profilepage.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _region = TextEditingController();
  final _battleTag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            // Overwatch Logo
            Image.asset(
              'assets/images/overwatch_logo.png',
              height: 200.0, width: 200.0),
            SizedBox(height: 100.0),
            // TODO: Change region to dropdown list or scroll select region (Map name to region code)
            TextField(
              controller: _region,
              autofocus: true,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'region',
                filled: true,
              ),
            ),
            SizedBox(height:20.0),
            // Battle tag name
            TextField(
              controller: _battleTag,
              autofocus: true,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Battle Tag',
                filled: true,
              ),
            ),
            // Clear Button + Submit to navigate to next page and query api
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CLEAR'),
                  onPressed: () {
                    print('Clear Button');
                    _region.clear();
                    _battleTag.clear();
                  },
                ),
                RaisedButton(
                  child: Text('SUBMIT'),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    print('Submit Button');
                    print(_region.text);
                    print(_battleTag.text);
                    Navigator.push(
                      context, ProfilePage(_region.text, _battleTag.text));
                  },
                ),
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}
