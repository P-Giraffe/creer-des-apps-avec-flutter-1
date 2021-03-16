import 'game.dart';

class GamesManager {
  Game? _currentGame;
  final List<Game> _previousGames = [];

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
