import '../models/counter.dart';

/// Source de données de type base de données.
///
/// Cette classe représente la base de données de l'application. Elle n'est pas
/// encore réellement implémentée : les compteurs sont conservés dans une liste
/// en mémoire. Une véritable implémentation (sqflite, etc.) viendra plus tard
/// remplacer ce stockage en mémoire sans changer la signature des méthodes.
///
/// Les méthodes sont asynchrones car un accès à une vraie base de données l'est
/// toujours.
class CounterDatabaseDataSource {
  final List<Counter> _counters = [];

  /// Prochain identifiant à attribuer. Joue le rôle de l'auto-incrément d'une
  /// vraie base de données.
  int _nextId = 1;

  /// Charge la liste de tous les compteurs stockés.
  Future<List<Counter>> loadCounters() async {
    return List<Counter>.unmodifiable(_counters);
  }

  /// Charge le compteur portant l'identifiant donné, ou null s'il n'existe pas.
  Future<Counter?> loadCounter(int id) async {
    final matches = _counters.where((counter) => counter.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  /// Crée un nouveau compteur en lui attribuant un identifiant unique, le stocke
  /// et retourne le compteur ainsi créé (avec son identifiant).
  Future<Counter> createCounter(Counter counter) async {
    final created = counter.copyWith(id: _nextId);
    _nextId++;
    _counters.add(created);
    return created;
  }

  /// Sauvegarde le compteur fourni en remplaçant celui qui porte le même
  /// identifiant. Sans effet si aucun compteur ne correspond.
  Future<void> saveCounter(Counter counter) async {
    final index = _counters.indexWhere((stored) => stored.id == counter.id);
    if (index >= 0) {
      _counters[index] = counter;
    }
  }

  /// Supprime le compteur portant l'identifiant donné.
  Future<void> deleteCounter(int id) async {
    _counters.removeWhere((counter) => counter.id == id);
  }
}
