import 'package:clicker/Model/game.dart';
import 'package:floor/floor.dart';

class GamesLocalDataManager {
  Future<void> addNewGame(Game game) async {}

  Future<List<Game>> getGamesList() async {
    return [];
  }
}

@entity
class FLGame {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String playerName;
  final int score;

  FLGame(this.id, this.playerName, this.score);

  FLGame.fromGame(Game game)
      : this.playerName = game.playerName,
        this.score = game.score;

  Game get game => Game(playerName: playerName, score: score);
}
