import '../data_source/local_ai_data_source.dart';
import 'ai_answer.dart';

/// Couche de gestion intermédiaire entre l'interface graphique et la source de
/// données d'IA locale.
///
/// L'interface graphique ne communique jamais directement avec la source de
/// données : elle passe toujours par ce service, qui porte la logique métier
/// (vérifier la disponibilité, préparer la session, poser une question…) et
/// délègue les appels au package à la source de données.
class LocalAiService {
  LocalAiService(this._dataSource);

  final LocalAiDataSource _dataSource;

  /// Instructions par défaut données au modèle lorsqu'aucune n'est précisée.
  static const String defaultInstructions =
      'Tu es un assistant utile et concis. Réponds en français.';

  /// Indique si l'IA locale est disponible sur l'appareil. À appeler avant
  /// toute génération.
  Future<bool> isAvailable() {
    return _dataSource.isAvailable();
  }

  /// Prépare le modèle en créant une session avec les instructions fournies
  /// (ou les instructions par défaut du service).
  Future<void> prepare({String instructions = defaultInstructions}) {
    return _dataSource.initialize(instructions: instructions);
  }

  /// Pose une question au modèle et retourne sa réponse.
  Future<AiAnswer> ask(String prompt, {int maxTokens = 200, double? temperature}) {
    return _dataSource.generateText(
      prompt: prompt,
      maxTokens: maxTokens,
      temperature: temperature,
    );
  }

  /// Ouvre le Play Store sur Google AICore (Android), utile pour aider
  /// l'utilisateur à installer le prérequis manquant (erreur -101).
  Future<bool> installAndroidRequirements() {
    return _dataSource.openAICoreInstaller();
  }
}
