import 'dart:async';

import 'package:clicker/Model/game.dart';
import 'package:clicker/Model/games_manager.dart';
import 'package:clicker/generated/l10n.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GamesManager manager = GamesManager();
  var _currentPlayerName = "";
  var _currentNameFieldController = TextEditingController();
  final List<Game> _resultList = [];

  _startCounting() {
    setState(() {
      manager.startNewGame(username: _currentPlayerName);
      Timer(Duration(seconds: 14), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      manager.finishCurrentGame();
    });
  }

  _clickButtonTouched() {
    setState(() {
      manager.currentGame?.userScored();
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
    final bestGame = manager.bestGame;
    final currentGame = manager.currentGame;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (manager.isGameInProgress == false)
              TextField(
                  autocorrect: false,
                  onChanged: _currentUsernameChanged,
                  controller: _currentNameFieldController),
            if (bestGame != null)
              Text(S.current.point_record(bestGame.playerName, bestGame.score)),
            if (currentGame != null)
              Text(S.current.click_count(currentGame.score)),
            if (manager.isGameInProgress)
              IconButton(
                  icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched),
            Expanded(
                child: ListView.builder(
                    itemCount: _resultList.length,
                    itemBuilder: _makeRowForResult)),
            if (manager.isGameInProgress == false)
              ElevatedButton(
                  onPressed: _startCounting,
                  child: Text(S.of(context).game_start_button)),
          ],
        ),
      ),
    );
  }
}
