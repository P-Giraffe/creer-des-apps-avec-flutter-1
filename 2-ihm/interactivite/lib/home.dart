import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _score = 0;
  _plusButtonClicked() {
    setState(() {
      _score = _score + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Score : $_score"),
          IconButton(
              icon: Icon(Icons.plus_one),
              iconSize: 50,
              onPressed: _plusButtonClicked)
        ],
      ),
    );
  }
}
