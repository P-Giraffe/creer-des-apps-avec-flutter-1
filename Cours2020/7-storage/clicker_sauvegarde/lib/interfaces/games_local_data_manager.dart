import 'package:clicker/Model/game.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'games_local_data_manager.g.dart'; // the generated code will be there

class GamesLocalDataManager {
  Future<GameDao> get _gameDao async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.gameDao;
  }

  Future<void> addNewGame(Game game) async {
    final gameDao = await _gameDao;
    return gameDao.insertGame(FLGame.fromGame(game));
  }

  Future<List<Game>> getGamesList() async {
    final gameDao = await _gameDao;
    final flGamesList = await gameDao.findAllGames();

    return flGamesList.map((flGame) => flGame.game).toList();
  }
}

@dao
abstract class GameDao {
  @Query('SELECT * FROM FLGame')
  Future<List<FLGame>> findAllGames();

  @insert
  Future<void> insertGame(FLGame game);
}

@entity
class FLGame {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String playerName;
  final int score;

  FLGame(this.id, this.playerName, this.score);

  FLGame.fromGame(Game game)
      : this.playerName = game.playerName,
        this.score = game.score;

  Game get game => Game(playerName: playerName, score: score);
}

@Database(version: 1, entities: [FLGame])
abstract class AppDatabase extends FloorDatabase {
  GameDao get gameDao;
}
