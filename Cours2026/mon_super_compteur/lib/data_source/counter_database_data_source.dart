import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
// Import préfixé pour accéder à la fabrique par défaut sans qu'elle soit masquée
// par le paramètre de même nom du constructeur.
import 'package:sqflite/sqflite.dart' as sqflite show databaseFactory;

import '../models/counter.dart';

/// Source de données de type base de données, adossée à SQLite (sqflite).
///
/// Toute la connaissance de la technologie de stockage est confinée ici : le
/// reste du projet (UI, modèles, service) ignore qu'il s'agit de SQLite et
/// dialogue uniquement avec les méthodes asynchrones ci-dessous.
///
/// La fabrique de base de données et le chemin du fichier sont injectables afin
/// de pouvoir, en test, utiliser une base en mémoire sans toucher au reste du
/// projet. En production, les valeurs par défaut ouvrent un vrai fichier SQLite
/// sur l'appareil.
class CounterDatabaseDataSource {
  CounterDatabaseDataSource({
    DatabaseFactory? databaseFactory,
    String? databasePath,
  }) : _databaseFactory = databaseFactory ?? sqflite.databaseFactory,
       _databasePath = databasePath;

  /// Nom de la table et de ses colonnes. Regroupés ici pour éviter les chaînes
  /// magiques dispersées dans les requêtes.
  static const String _table = 'counters';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnValue = 'value';
  static const String _columnGoal = 'goal';

  final DatabaseFactory _databaseFactory;
  final String? _databasePath;

  /// Base ouverte, conservée après la première ouverture (ouverture paresseuse).
  Database? _database;

  /// Retourne la base en l'ouvrant à la première utilisation.
  Future<Database> _openedDatabase() async {
    _database ??= await _databaseFactory.openDatabase(
      _databasePath ?? p.join(await _databaseFactory.getDatabasesPath(), 'counters.db'),
      options: OpenDatabaseOptions(version: 1, onCreate: _createSchema),
    );
    return _database!;
  }

  /// Crée la table des compteurs. La colonne identifiant joue le rôle
  /// d'auto-incrément de la base.
  Future<void> _createSchema(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_table('
      '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_columnName TEXT NOT NULL, '
      '$_columnValue INTEGER NOT NULL, '
      '$_columnGoal INTEGER'
      ')',
    );
  }

  /// Traduit une ligne de la base en compteur.
  Counter _counterFromRow(Map<String, Object?> row) {
    return Counter(
      id: row[_columnId] as int?,
      name: row[_columnName] as String,
      value: row[_columnValue] as int,
      goal: row[_columnGoal] as int?,
    );
  }

  /// Traduit un compteur en ligne de la base. L'identifiant n'est pas inclus :
  /// il est soit attribué par l'auto-incrément, soit utilisé comme critère de
  /// recherche dans les requêtes.
  Map<String, Object?> _rowFromCounter(Counter counter) {
    return {
      _columnName: counter.name,
      _columnValue: counter.value,
      _columnGoal: counter.goal,
    };
  }

  /// Charge la liste de tous les compteurs stockés.
  Future<List<Counter>> loadCounters() async {
    final db = await _openedDatabase();
    final rows = await db.query(_table, orderBy: _columnId);
    return List<Counter>.unmodifiable(rows.map(_counterFromRow));
  }

  /// Charge le compteur portant l'identifiant donné, ou null s'il n'existe pas.
  Future<Counter?> loadCounter(int id) async {
    final db = await _openedDatabase();
    final rows = await db.query(
      _table,
      where: '$_columnId = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : _counterFromRow(rows.first);
  }

  /// Crée un nouveau compteur en lui attribuant un identifiant unique, le stocke
  /// et retourne le compteur ainsi créé (avec son identifiant).
  Future<Counter> createCounter(Counter counter) async {
    final db = await _openedDatabase();
    final id = await db.insert(_table, _rowFromCounter(counter));
    return counter.copyWith(id: id);
  }

  /// Sauvegarde le compteur fourni en remplaçant celui qui porte le même
  /// identifiant. Sans effet si aucun compteur ne correspond.
  Future<void> saveCounter(Counter counter) async {
    final db = await _openedDatabase();
    await db.update(
      _table,
      _rowFromCounter(counter),
      where: '$_columnId = ?',
      whereArgs: [counter.id],
    );
  }

  /// Supprime le compteur portant l'identifiant donné.
  Future<void> deleteCounter(int id) async {
    final db = await _openedDatabase();
    await db.delete(_table, where: '$_columnId = ?', whereArgs: [id]);
  }

  /// Ferme la base si elle est ouverte. La prochaine utilisation la rouvrira.
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
