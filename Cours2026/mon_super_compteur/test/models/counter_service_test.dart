import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/data_source/counter_database_data_source.dart';
import 'package:mon_super_compteur/models/counter_service.dart';

void main() {
  late CounterService service;

  setUp(() {
    service = CounterService(CounterDatabaseDataSource());
  });

  test('loadCounters is empty at start', () async {
    final counters = await service.loadCounters();

    expect(counters, isEmpty);
  });

  test('createCounter stores a counter with an id and value 0', () async {
    final created = await service.createCounter(name: 'Pompes', goal: 10);

    expect(created.id, isNotNull);
    expect(created.name, 'Pompes');
    expect(created.value, 0);
    expect(created.goal, 10);

    final counters = await service.loadCounters();
    expect(counters, hasLength(1));
    expect(counters.first.id, created.id);
  });

  test('increment raises the value of the targeted counter only', () async {
    final first = await service.createCounter(name: 'Pompes');
    final second = await service.createCounter(name: 'Tractions');

    await service.increment(first);

    final reloadedFirst = await service.loadCounters().then(
      (counters) => counters.firstWhere((c) => c.id == first.id),
    );
    final reloadedSecond = await service.loadCounters().then(
      (counters) => counters.firstWhere((c) => c.id == second.id),
    );

    expect(reloadedFirst.value, 1);
    expect(reloadedSecond.value, 0);
  });

  test('decrement lowers the value and persists it', () async {
    final created = await service.createCounter(name: 'Pompes');
    final incremented = await service.increment(created);

    final decremented = await service.decrement(incremented);
    expect(decremented.value, 0);

    final reloaded = await service.loadCounters();
    expect(reloaded.first.value, 0);
  });

  test('rename updates the name while keeping the id', () async {
    final created = await service.createCounter();

    final renamed = await service.rename(created, 'Pompes');
    expect(renamed.name, 'Pompes');
    expect(renamed.id, created.id);

    final reloaded = await service.loadCounters();
    expect(reloaded.first.name, 'Pompes');
  });

  test('updateGoal sets the goal while keeping the id', () async {
    final created = await service.createCounter();

    final withGoal = await service.updateGoal(created, 10);
    expect(withGoal.goal, 10);
    expect(withGoal.id, created.id);

    final reloaded = await service.loadCounters();
    expect(reloaded.first.goal, 10);
  });

  test('updateGoal can clear the goal back to null', () async {
    final created = await service.createCounter(goal: 10);

    final cleared = await service.updateGoal(created, null);
    expect(cleared.goal, isNull);

    final reloaded = await service.loadCounters();
    expect(reloaded.first.goal, isNull);
  });

  test('deleteCounter removes the counter from the list', () async {
    final first = await service.createCounter(name: 'Pompes');
    final second = await service.createCounter(name: 'Tractions');

    await service.deleteCounter(first);

    final counters = await service.loadCounters();
    expect(counters, hasLength(1));
    expect(counters.first.id, second.id);
  });

  group('loadCounter', () {
    test('returns the counter matching the id', () async {
      await service.createCounter(name: 'Pompes');
      final second = await service.createCounter(name: 'Tractions');

      final loaded = await service.loadCounter(second.id!);

      expect(loaded, isNotNull);
      expect(loaded!.id, second.id);
      expect(loaded.name, 'Tractions');
    });

    test('returns null for an unknown id', () async {
      await service.createCounter(name: 'Pompes');

      final loaded = await service.loadCounter(999);

      expect(loaded, isNull);
    });
  });
}
