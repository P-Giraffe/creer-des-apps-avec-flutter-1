import 'dart:async';

import 'package:clicker/Model/game.dart';
import 'package:clicker/generated/l10n.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _currentPlayerName = "";
  var _clickCount = 0;
  var _isCounting = false;
  int? _bestScore = null;
  var _bestPlayerName = "";
  var _currentNameFieldController = TextEditingController();
  final List<Game> _resultList = [];

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
      final result = Game(_currentPlayerName, _clickCount);
      _resultList.add(result);
      final bestScore = _bestScore;
      if (bestScore == null || _clickCount > bestScore) {
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
        Text(S.of(context).result_score_points(result.score))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bestScore = _bestScore;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
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
            if (bestScore != null)
              Text(S.current.point_record(_bestPlayerName, bestScore)),
            Text(S.current.click_count(_clickCount)),
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
                  child: Text(S.of(context).game_start_button)),
          ],
        ),
      ),
    );
  }
}
