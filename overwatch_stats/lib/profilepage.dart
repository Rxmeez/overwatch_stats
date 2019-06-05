import 'package:flutter/material.dart';

class ProfilePage extends MaterialPageRoute<Null> {
  final String _region;
  final String _battleTag;

  ProfilePage(this._region, this._battleTag)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              title: Text('$_battleTag'.split('-')[0]),
            ),
            body: Center(
              child: RaisedButton(
                child: Text('Welcome $_battleTag'),
                onPressed: () {
                  print("Page 2 Button Pressed");
                },
              ),
            ),
          );
        });
}
