import 'dart:async';

import 'package:clicker/Model/game.dart';
import 'package:clicker/Model/games_manager.dart';
import 'package:clicker/generated/l10n.dart';
import 'package:clicker/ui/hall_of_fame_screen.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final gamesManager = GamesManager();
  var _currentPlayerName = "";
  var _currentNameFieldController = TextEditingController();

  _startCounting() {
    setState(() {
      gamesManager.startNewGame(userName: _currentPlayerName);
      Timer(Duration(seconds: GamesManager.gamesDuration), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      gamesManager.finishCurrentGame();
    });
  }

  _clickButtonTouched() {
    setState(() {
      gamesManager.currentGame?.userScored();
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

  @override
  Widget build(BuildContext context) {
    final bestGame = gamesManager.bestGame;
    final currentGame = gamesManager.currentGame;
    bool isGameInProgress = gamesManager.isGameInProgress;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isGameInProgress == false)
              TextField(
                  autocorrect: false,
                  onChanged: _currentUsernameChanged,
                  controller: _currentNameFieldController),
            if (bestGame != null)
              Text(S.current.point_record(bestGame.playerName, bestGame.score)),
            if (currentGame != null)
              Text(S.current.click_count(currentGame.score))
            else
              Text(S.of(context).before_game_text),
            if (isGameInProgress)
              IconButton(
                  icon: Icon(Icons.plus_one), onPressed: _clickButtonTouched)
            else
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HallOfFameScreen(gameList: gamesManager.bestGameList),
                    ));
                  },
                  child: Text(S.of(context).hall_of_fame)),
            Spacer(),
            if (isGameInProgress == false)
              ElevatedButton(
                  onPressed: _startCounting,
                  child: Text(S.of(context).game_start_button)),
          ],
        ),
      ),
    );
  }
}
