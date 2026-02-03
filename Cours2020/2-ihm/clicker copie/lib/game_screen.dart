import 'dart:async';

import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clicker"),
      ),
      body: SafeArea(child: GameView()),
    );
  }
}

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  var _clickCount = 0;
  var _isCounting = false;
  int _record = null;

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
      if (_record == null || _clickCount > _record) {
        _record = _clickCount;
      }
    });
  }

  _clickButtonTouched() {
    setState(() {
      _clickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_record != null) Text("Record de points : $_record"),
        Text("Nombre de clics : $_clickCount"),
        if (_isCounting)
          IconButton(
              icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched),
        Spacer(),
        if (_isCounting == false)
          ElevatedButton(
              onPressed: _startCounting, child: Text("Commencer à compter")),
      ],
    );
  }
}
