import 'package:flutter_local_ai/flutter_local_ai.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/data_source/local_ai_data_source.dart';

import '../fakes/fake_local_ai_engine.dart';

void main() {
  late FakeLocalAiEngine engine;
  late LocalAiDataSource dataSource;

  setUp(() {
    engine = FakeLocalAiEngine();
    dataSource = LocalAiDataSource(engine: engine);
  });

  test('isAvailable delegates to the engine', () async {
    engine.available = false;

    expect(await dataSource.isAvailable(), isFalse);
  });

  test('initialize forwards the instructions to the engine', () async {
    await dataSource.initialize(instructions: 'Sois bref');

    expect(engine.lastInstructions, 'Sois bref');
  });

  test('generateText builds the config from its parameters', () async {
    await dataSource.generateText(
      prompt: 'Bonjour',
      maxTokens: 50,
      temperature: 0.3,
    );

    expect(engine.lastPrompt, 'Bonjour');
    expect(engine.lastConfig?.maxTokens, 50);
    expect(engine.lastConfig?.temperature, 0.3);
  });

  test('generateText defaults maxTokens to 200', () async {
    await dataSource.generateText(prompt: 'Bonjour');

    expect(engine.lastConfig?.maxTokens, 200);
    expect(engine.lastConfig?.temperature, isNull);
  });

  test('generateText maps the AiResponse to an AiAnswer', () async {
    engine.response = const AiResponse(
      text: 'Salut',
      tokenCount: 12,
      generationTimeMs: 99,
    );

    final answer = await dataSource.generateText(prompt: 'Bonjour');

    expect(answer.text, 'Salut');
    expect(answer.tokenCount, 12);
    expect(answer.generationTimeMs, 99);
  });

  test('openAICoreInstaller delegates to the engine', () async {
    engine.playStoreOpened = true;

    final opened = await dataSource.openAICoreInstaller();

    expect(opened, isTrue);
    expect(engine.playStoreRequested, isTrue);
  });
}
