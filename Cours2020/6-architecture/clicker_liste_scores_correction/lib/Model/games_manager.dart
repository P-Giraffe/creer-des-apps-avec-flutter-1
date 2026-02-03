import 'package:clicker/Model/game.dart';

class GamesManager {
  Game? _currentGame;
  List<Game> _previousGames = [];

  Game? get currentGame => _currentGame;
  Game? get bestGame {
    Game? topGame;
    for (var game in _previousGames) {
      if (topGame == null || topGame.score < game.score) {
        topGame = game;
      }
    }
    return topGame;
  }

  bool get isGameInProgress {
    final game = _currentGame;
    return game != null && game.isInProgress;
  }

  startNewGame({required String username}) {
    final newGame = Game(playerName: username);
    newGame.start();
    _currentGame = newGame;
  }

  finishCurrentGame() {
    final game = _currentGame;
    if (game != null) {
      game.finish();
      _previousGames.add(game);
    }
  }
}
