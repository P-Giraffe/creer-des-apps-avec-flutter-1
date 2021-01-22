import 'dart:async';

import 'package:clicker/Model/game_result.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _currentPlayerName = "";
  var _clickCount = 0;
  var _isCounting = false;
  int _bestScore = null;
  var _bestPlayerName = "";
  var _currentNameFieldController = TextEditingController();
  final List<GameResult> _resultList = [];

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
      final result = GameResult(_currentPlayerName, _clickCount);
      _resultList.add(result);
      if (_bestScore == null || _clickCount > _bestScore) {
        _bestScore = _clickCount;
        _bestPlayerName = _currentPlayerName;
      }
    });
  }

  _clickButtonTouched() {
    setState(() {
      _clickCount++;
    });
  }

  _currentUsernameChanged(String newUsername) {
    setState(() {
      _currentPlayerName = newUsername;
    });
  }

  @override
  void dispose() {
    _currentNameFieldController.dispose();
    super.dispose();
  }

  Widget _makeRowForResult(BuildContext context, int rowNumber) {
    final result = _resultList[rowNumber];
    return Row(
      children: [
        Text(result.playerName),
        Icon(Icons.military_tech),
        Text("${result.score} points")
      ],
    );
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
            if (_isCounting == false)
              TextField(
                  autocorrect: false,
                  onChanged: _currentUsernameChanged,
                  controller: _currentNameFieldController),
            if (_bestScore != null)
              Text("Record de points : $_bestPlayerName $_bestScore"),
            Text("Nombre de clics : $_clickCount"),
            if (_isCounting)
              IconButton(
                  icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched),
            Expanded(
                child: ListView.builder(
                    itemCount: _resultList.length,
                    itemBuilder: _makeRowForResult)),
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
