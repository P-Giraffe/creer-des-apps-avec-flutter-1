import '../models/counter.dart';

/// Source de données de type base de données.
///
/// Cette classe représente la base de données de l'application. Elle n'est pas
/// encore réellement implémentée : les données sont conservées dans une variable
/// en mémoire. Une véritable implémentation (sqflite, etc.) viendra plus tard
/// remplacer ce stockage en mémoire sans changer la signature des méthodes.
///
/// Les méthodes sont asynchrones car un accès à une vraie base de données l'est
/// toujours.
class CounterDatabaseDataSource {
  Counter _storedCounter = const Counter();

  /// Charge le compteur stocké.
  Future<Counter> loadCounter() async {
    return _storedCounter;
  }

  /// Sauvegarde le compteur fourni.
  Future<void> saveCounter(Counter counter) async {
    _storedCounter = counter;
  }
}
