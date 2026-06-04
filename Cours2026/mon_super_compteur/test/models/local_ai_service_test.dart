import 'package:flutter_local_ai/flutter_local_ai.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mon_super_compteur/data_source/local_ai_data_source.dart';
import 'package:mon_super_compteur/models/local_ai_service.dart';

import '../fakes/fake_local_ai_engine.dart';

void main() {
  late FakeLocalAiEngine engine;
  late LocalAiService service;

  setUp(() {
    // Source de données réelle adossée à un moteur factice, comme les tests du
    // service compteur s'appuient sur une base SQLite en mémoire.
    engine = FakeLocalAiEngine();
    service = LocalAiService(LocalAiDataSource(engine: engine));
  });

  test('isAvailable delegates down to the engine', () async {
    engine.available = false;

    expect(await service.isAvailable(), isFalse);
  });

  test('prepare uses the default instructions when none is given', () async {
    await service.prepare();

    expect(engine.lastInstructions, LocalAiService.defaultInstructions);
  });

  test('prepare forwards custom instructions', () async {
    await service.prepare(instructions: 'Réponds comme un pirate');

    expect(engine.lastInstructions, 'Réponds comme un pirate');
  });

  test('ask defaults maxTokens to 200 and returns the answer', () async {
    engine.response = const AiResponse(text: 'Ahoy');

    final answer = await service.ask('Bonjour');

    expect(engine.lastPrompt, 'Bonjour');
    expect(engine.lastConfig?.maxTokens, 200);
    expect(answer.text, 'Ahoy');
  });

  test('installAndroidRequirements delegates to the engine', () async {
    final opened = await service.installAndroidRequirements();

    expect(opened, isTrue);
    expect(engine.playStoreRequested, isTrue);
  });
}
