import 'package:flutter_local_ai/flutter_local_ai.dart';
import 'package:mon_super_compteur/data_source/local_ai_data_source.dart';

/// Moteur d'IA factice pour les tests : implémente la couture [LocalAiEngine]
/// sans aucun canal de plateforme, et capture les paramètres reçus pour
/// permettre les assertions.
class FakeLocalAiEngine implements LocalAiEngine {
  FakeLocalAiEngine({
    this.available = true,
    this.response = const AiResponse(
      text: 'réponse factice',
      tokenCount: 7,
      generationTimeMs: 42,
    ),
    this.playStoreOpened = true,
  });

  /// Valeur renvoyée par [isAvailable].
  bool available;

  /// Réponse renvoyée par [generateText].
  AiResponse response;

  /// Valeur renvoyée par [openAICorePlayStore].
  bool playStoreOpened;

  /// Dernières instructions reçues par [initialize].
  String? lastInstructions;

  /// Dernier prompt reçu par [generateText].
  String? lastPrompt;

  /// Dernière configuration reçue par [generateText].
  GenerationConfig? lastConfig;

  /// Indique si [openAICorePlayStore] a été appelé.
  bool playStoreRequested = false;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<bool> initialize({String? instructions}) async {
    lastInstructions = instructions;
    return true;
  }

  @override
  Future<AiResponse> generateText({
    required String prompt,
    GenerationConfig? config,
  }) async {
    lastPrompt = prompt;
    lastConfig = config;
    return response;
  }

  @override
  Future<bool> openAICorePlayStore() async {
    playStoreRequested = true;
    return playStoreOpened;
  }
}
