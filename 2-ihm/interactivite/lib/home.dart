import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _plusButtonClicked() {
    print("Bazinga!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
              icon: Icon(Icons.plus_one),
              iconSize: 50,
              onPressed: _plusButtonClicked)
        ],
      ),
    );
  }
}
