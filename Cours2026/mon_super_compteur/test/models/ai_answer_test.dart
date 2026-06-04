import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/models/ai_answer.dart';

void main() {
  group('AiAnswer.hasText', () {
    test('is true when the text contains visible characters', () {
      const answer = AiAnswer(text: 'Bonjour');
      expect(answer.hasText, isTrue);
    });

    test('is false for an empty text', () {
      const answer = AiAnswer(text: '');
      expect(answer.hasText, isFalse);
    });

    test('is false for a blank text', () {
      const answer = AiAnswer(text: '   ');
      expect(answer.hasText, isFalse);
    });
  });

  group('AiAnswer.copyWith', () {
    test('replaces the text and keeps the rest', () {
      const answer = AiAnswer(text: 'a', tokenCount: 3, generationTimeMs: 10);
      final updated = answer.copyWith(text: 'b');

      expect(updated.text, 'b');
      expect(updated.tokenCount, 3);
      expect(updated.generationTimeMs, 10);
    });

    test('does not mutate the original answer', () {
      const answer = AiAnswer(text: 'a', tokenCount: 3);
      answer.copyWith(text: 'b');

      expect(answer.text, 'a');
    });
  });
}
