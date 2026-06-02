import '../data_source/counter_database_data_source.dart';
import 'counter.dart';

/// Couche de gestion intermédiaire entre l'interface graphique et la source de
/// données.
///
/// L'interface graphique ne communique jamais directement avec la source de
/// données : elle passe toujours par ce service, qui porte la logique métier
/// (créer, incrémenter, supprimer…) et délègue la persistance à la source de
/// données.
class CounterService {
  CounterService(this._dataSource);

  final CounterDatabaseDataSource _dataSource;

  /// Charge la liste de tous les compteurs.
  Future<List<Counter>> loadCounters() {
    return _dataSource.loadCounters();
  }

  /// Charge un compteur précis par son identifiant, ou null s'il n'existe pas.
  Future<Counter?> loadCounter(int id) {
    return _dataSource.loadCounter(id);
  }

  /// Crée un nouveau compteur (valeur initiale 0) et retourne le compteur créé
  /// avec l'identifiant attribué par la source de données.
  Future<Counter> createCounter({String name = '', int? goal}) {
    return _dataSource.createCounter(Counter(name: name, goal: goal));
  }

  /// Incrémente la valeur du compteur, persiste et retourne le compteur à jour.
  Future<Counter> increment(Counter current) async {
    final updated = current.copyWith(value: current.value + 1);
    await _dataSource.saveCounter(updated);
    return updated;
  }

  /// Décrémente la valeur du compteur, persiste et retourne le compteur à jour.
  Future<Counter> decrement(Counter current) async {
    final updated = current.copyWith(value: current.value - 1);
    await _dataSource.saveCounter(updated);
    return updated;
  }

  /// Renomme le compteur, persiste et retourne le compteur à jour.
  Future<Counter> rename(Counter current, String name) async {
    final updated = current.copyWith(name: name);
    await _dataSource.saveCounter(updated);
    return updated;
  }

  /// Met à jour l'objectif (éventuellement à null), persiste et retourne le
  /// compteur à jour. L'identifiant est conservé.
  Future<Counter> updateGoal(Counter current, int? goal) async {
    final updated = Counter(
      id: current.id,
      name: current.name,
      value: current.value,
      goal: goal,
    );
    await _dataSource.saveCounter(updated);
    return updated;
  }

  /// Supprime le compteur fourni.
  Future<void> deleteCounter(Counter counter) async {
    await _dataSource.deleteCounter(counter.id!);
  }
}
