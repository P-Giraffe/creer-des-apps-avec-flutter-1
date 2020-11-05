import 'dart:async';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _clickCount = 0;
  var _isCounting = false;

  _startCounting() {
    setState(() {
      _clickCount = 0;
      _isCounting = true;
      Timer(Duration(seconds: 10), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      _isCounting = false;
    });
  }

  _clickButtonTouched() {
    setState(() {
      _clickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicker"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nombre de clics : $_clickCount"),
            if (_isCounting)
              IconButton(
                  icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched),
            Spacer(),
            if (_isCounting == false)
              ElevatedButton(
                  onPressed: _startCounting,
                  child: Text("Commencer à compter")),
          ],
        ),
      ),
    );
  }
}
