import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _clickCount = 0;
  var _isCounting = false;

  _startCounting() {}

  _clickButtonTouched() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicker"),
      ),
      body: Column(
        children: [
          Text("Nombre de clics : $_clickCount"),
          if (_isCounting == false)
            ElevatedButton(
                onPressed: _startCounting, child: Text("Commencer à compter")),
          if (_isCounting)
            IconButton(
                icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched)
        ],
      ),
    );
  }
}
