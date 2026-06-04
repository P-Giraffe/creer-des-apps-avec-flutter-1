import 'package:flutter_local_ai/flutter_local_ai.dart';

import '../models/ai_answer.dart';

/// Abstraction du moteur d'IA locale, seule porte d'entrée vers le package
/// `flutter_local_ai`.
///
/// Le package n'expose qu'une classe concrète (`FlutterLocalAi`) reposant sur
/// des canaux de plateforme, impossible à exécuter hors d'un appareil. Cette
/// interface joue donc le même rôle que la fabrique injectable de la source de
/// données SQLite : elle permet d'injecter une implémentation de test sans
/// toucher au reste du projet. En production, [FlutterLocalAiEngine] délègue au
/// vrai package.
abstract class LocalAiEngine {
  Future<bool> isAvailable();

  Future<bool> initialize({String? instructions});

  Future<AiResponse> generateText({
    required String prompt,
    GenerationConfig? config,
  });

  Future<bool> openAICorePlayStore();
}

/// Implémentation par défaut du moteur, adossée au package `flutter_local_ai`.
class FlutterLocalAiEngine implements LocalAiEngine {
  FlutterLocalAiEngine() : _ai = FlutterLocalAi();

  final FlutterLocalAi _ai;

  @override
  Future<bool> isAvailable() => _ai.isAvailable();

  @override
  Future<bool> initialize({String? instructions}) =>
      _ai.initialize(instructions: instructions);

  @override
  Future<AiResponse> generateText({
    required String prompt,
    GenerationConfig? config,
  }) => _ai.generateText(prompt: prompt, config: config);

  @override
  Future<bool> openAICorePlayStore() => _ai.openAICorePlayStore();
}

/// Source de données d'IA locale, adossée au package `flutter_local_ai`.
///
/// Toute la connaissance du package est confinée ici : le reste du projet
/// (UI, modèles, service) ignore qu'il s'agit de `flutter_local_ai` et dialogue
/// uniquement avec les méthodes asynchrones ci-dessous, qui parlent en
/// [AiAnswer] (modèle du projet) et non en types du package.
///
/// Le moteur est injectable afin de pouvoir, en test, utiliser une
/// implémentation factice sans appareil. En production, la valeur par défaut
/// utilise les APIs natives de l'OS.
class LocalAiDataSource {
  LocalAiDataSource({LocalAiEngine? engine})
    : _engine = engine ?? FlutterLocalAiEngine();

  final LocalAiEngine _engine;

  /// Traduit une réponse du package en réponse du modèle du projet.
  AiAnswer _answerFromResponse(AiResponse response) {
    return AiAnswer(
      text: response.text,
      tokenCount: response.tokenCount,
      generationTimeMs: response.generationTimeMs,
    );
  }

  /// Indique si l'IA locale est disponible sur l'appareil.
  Future<bool> isAvailable() {
    return _engine.isAvailable();
  }

  /// Initialise le modèle et crée une session avec les instructions données.
  Future<void> initialize({String? instructions}) async {
    await _engine.initialize(instructions: instructions);
  }

  /// Génère un texte à partir d'un prompt et retourne la réponse traduite en
  /// [AiAnswer].
  Future<AiAnswer> generateText({
    required String prompt,
    int maxTokens = 200,
    double? temperature,
  }) async {
    final response = await _engine.generateText(
      prompt: prompt,
      config: GenerationConfig(maxTokens: maxTokens, temperature: temperature),
    );
    return _answerFromResponse(response);
  }

  /// Ouvre Google AICore dans le Play Store (Android uniquement), utile pour
  /// gérer l'erreur -101 « AICore non installé ». Retourne false si la
  /// plateforme ne le gère pas.
  Future<bool> openAICoreInstaller() {
    return _engine.openAICorePlayStore();
  }
}
