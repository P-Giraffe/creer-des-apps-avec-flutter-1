import 'game.dart';

class GamesManager {
  static const gamesDuration = 10;
  Game? _currentGame;
  final List<Game> _previousGames = [];

  List<Game> get bestGameList {
    final sortedList = List<Game>.from(_previousGames);
    sortedList.sort((game1, game2) => game2.compareTo(game1));
    return sortedList;
  }

  Game? get currentGame => _currentGame;
  Game? get bestGame {
    Game? topGame;
    for (final game in _previousGames) {
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

  startNewGame({required String userName}) {
    final newGame = Game(playerName: userName);
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
