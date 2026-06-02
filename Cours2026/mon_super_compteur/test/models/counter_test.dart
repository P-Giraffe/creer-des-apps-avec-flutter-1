import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/models/counter.dart';

void main() {
  group('Counter.isGoalReached', () {
    test('is false when no goal is set', () {
      const counter = Counter(value: 5);
      expect(counter.isGoalReached, isFalse);
    });

    test('is false when goal is zero', () {
      const counter = Counter(value: 5, goal: 0);
      expect(counter.isGoalReached, isFalse);
    });

    test('is false when value is below the goal', () {
      const counter = Counter(value: 3, goal: 10);
      expect(counter.isGoalReached, isFalse);
    });

    test('is true when value reaches the goal', () {
      const counter = Counter(value: 10, goal: 10);
      expect(counter.isGoalReached, isTrue);
    });

    test('is true when value exceeds the goal', () {
      const counter = Counter(value: 12, goal: 10);
      expect(counter.isGoalReached, isTrue);
    });
  });

  group('Counter.copyWith', () {
    test('replaces the value and keeps the rest', () {
      const counter = Counter(name: 'Pompes', value: 3, goal: 10);
      final updated = counter.copyWith(value: 4);

      expect(updated.value, 4);
      expect(updated.name, 'Pompes');
      expect(updated.goal, 10);
    });

    test('replaces the name and keeps the rest', () {
      const counter = Counter(name: 'Pompes', value: 3, goal: 10);
      final updated = counter.copyWith(name: 'Tractions');

      expect(updated.name, 'Tractions');
      expect(updated.value, 3);
      expect(updated.goal, 10);
    });

    test('does not mutate the original counter', () {
      const counter = Counter(name: 'Pompes', value: 3, goal: 10);
      counter.copyWith(value: 99);

      expect(counter.value, 3);
    });

    test('keeps the id by default', () {
      const counter = Counter(id: 7, name: 'Pompes', value: 3);
      final updated = counter.copyWith(value: 4);

      expect(updated.id, 7);
    });

    test('replaces the id when one is provided', () {
      const counter = Counter(name: 'Pompes', value: 3);
      final updated = counter.copyWith(id: 42);

      expect(updated.id, 42);
    });
  });
}
