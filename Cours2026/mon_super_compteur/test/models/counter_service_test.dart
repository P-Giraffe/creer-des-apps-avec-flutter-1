import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/data_source/counter_database_data_source.dart';
import 'package:mon_super_compteur/models/counter.dart';
import 'package:mon_super_compteur/models/counter_service.dart';

void main() {
  late CounterService service;

  setUp(() {
    service = CounterService(CounterDatabaseDataSource());
  });

  test('loadCounter returns the default counter at start', () async {
    final counter = await service.loadCounter();

    expect(counter.value, 0);
    expect(counter.name, '');
    expect(counter.goal, isNull);
  });

  test('increment raises the value and persists it', () async {
    final incremented = await service.increment(const Counter(value: 4));
    expect(incremented.value, 5);

    final reloaded = await service.loadCounter();
    expect(reloaded.value, 5);
  });

  test('decrement lowers the value and persists it', () async {
    final decremented = await service.decrement(const Counter(value: 4));
    expect(decremented.value, 3);

    final reloaded = await service.loadCounter();
    expect(reloaded.value, 3);
  });

  test('rename updates the name and persists it', () async {
    final renamed = await service.rename(const Counter(value: 2), 'Pompes');
    expect(renamed.name, 'Pompes');
    expect(renamed.value, 2);

    final reloaded = await service.loadCounter();
    expect(reloaded.name, 'Pompes');
  });

  test('updateGoal sets the goal and persists it', () async {
    final withGoal = await service.updateGoal(const Counter(value: 2), 10);
    expect(withGoal.goal, 10);

    final reloaded = await service.loadCounter();
    expect(reloaded.goal, 10);
  });

  test('updateGoal can clear the goal back to null', () async {
    final cleared = await service.updateGoal(
      const Counter(value: 2, goal: 10),
      null,
    );

    expect(cleared.goal, isNull);
  });
}
