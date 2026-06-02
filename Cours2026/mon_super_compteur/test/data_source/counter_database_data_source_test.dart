import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/data_source/counter_database_data_source.dart';
import 'package:mon_super_compteur/models/counter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late CounterDatabaseDataSource dataSource;

  setUpAll(() {
    sqfliteFfiInit();
  });

  setUp(() {
    // Base SQLite en mémoire, recréée vierge pour chaque test.
    dataSource = CounterDatabaseDataSource(
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
  });

  tearDown(() async {
    // Ferme la base pour repartir d'un stockage vierge au test suivant.
    await dataSource.close();
  });

  test('loadCounters is empty at start', () async {
    final counters = await dataSource.loadCounters();

    expect(counters, isEmpty);
  });

  test('createCounter assigns increasing and distinct ids', () async {
    final first = await dataSource.createCounter(const Counter(name: 'Pompes'));
    final second = await dataSource.createCounter(
      const Counter(name: 'Tractions'),
    );

    expect(first.id, 1);
    expect(second.id, 2);
    expect(first.value, 0);
    expect(second.value, 0);

    final counters = await dataSource.loadCounters();
    expect(counters, hasLength(2));
  });

  test('loadCounter returns the matching counter', () async {
    final created = await dataSource.createCounter(const Counter(name: 'Pompes'));

    final loaded = await dataSource.loadCounter(created.id!);

    expect(loaded, isNotNull);
    expect(loaded!.name, 'Pompes');
  });

  test('loadCounter returns null when the id is unknown', () async {
    final loaded = await dataSource.loadCounter(999);

    expect(loaded, isNull);
  });

  test('saveCounter updates the targeted counter without touching others',
      () async {
    final first = await dataSource.createCounter(const Counter(name: 'Pompes'));
    final second = await dataSource.createCounter(
      const Counter(name: 'Tractions'),
    );

    await dataSource.saveCounter(first.copyWith(value: 5));

    final reloadedFirst = await dataSource.loadCounter(first.id!);
    final reloadedSecond = await dataSource.loadCounter(second.id!);

    expect(reloadedFirst!.value, 5);
    expect(reloadedSecond!.value, 0);
  });

  test('deleteCounter removes the targeted counter only', () async {
    final first = await dataSource.createCounter(const Counter(name: 'Pompes'));
    final second = await dataSource.createCounter(
      const Counter(name: 'Tractions'),
    );

    await dataSource.deleteCounter(first.id!);

    final counters = await dataSource.loadCounters();
    expect(counters, hasLength(1));
    expect(counters.first.id, second.id);
  });
}
