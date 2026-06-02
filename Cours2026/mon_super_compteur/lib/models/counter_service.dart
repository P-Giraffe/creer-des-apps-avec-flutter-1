import '../data_source/counter_database_data_source.dart';
import 'counter.dart';

/// Couche de gestion intermédiaire entre l'interface graphique et la source de
/// données.
///
/// L'interface graphique ne communique jamais directement avec la source de
/// données : elle passe toujours par ce service, qui porte la logique métier
/// (incrémenter, décrémenter…) et délègue la persistance à la source de données.
class CounterService {
  CounterService(this._dataSource);

  final CounterDatabaseDataSource _dataSource;

  /// Charge le compteur courant.
  Future<Counter> loadCounter() {
    return _dataSource.loadCounter();
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
  /// compteur à jour.
  Future<Counter> updateGoal(Counter current, int? goal) async {
    final updated = Counter(
      name: current.name,
      value: current.value,
      goal: goal,
    );
    await _dataSource.saveCounter(updated);
    return updated;
  }
}
