import 'package:clicker/Model/game.dart';
import 'package:clicker/generated/l10n.dart';
import 'package:flutter/material.dart';

class HallOfFameScreen extends StatelessWidget {
  final List<Game> _gameList;

  const HallOfFameScreen({Key? key, required gameList})
      : _gameList = gameList,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hall of fame"),
      ),
      body: ListView.builder(
          itemCount: _gameList.length, itemBuilder: _makeRowForResult),
    );
  }

  Widget _makeRowForResult(BuildContext context, int rowNumber) {
    final result = _gameList[rowNumber];
    return Row(
      children: [
        Text(result.playerName),
        Icon(Icons.military_tech),
        Text(S.of(context).result_score_points(result.score))
      ],
    );
  }
}
