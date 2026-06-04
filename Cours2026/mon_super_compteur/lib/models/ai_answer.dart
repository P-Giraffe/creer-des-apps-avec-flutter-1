/// Modèle de données représentant une réponse générée par l'IA locale.
///
/// Classe immuable, indépendante de Flutter et de toute bibliothèque (y compris
/// du package d'IA) : elle ne décrit que les données produites par une
/// génération et la logique métier qui leur est propre.
class AiAnswer {
  const AiAnswer({required this.text, this.tokenCount, this.generationTimeMs});

  /// Texte généré par le modèle.
  final String text;

  /// Nombre de jetons consommés, ou null si la plateforme ne le fournit pas.
  final int? tokenCount;

  /// Durée de génération en millisecondes, ou null si non fournie.
  final int? generationTimeMs;

  /// Vrai lorsque la réponse contient du texte exploitable.
  bool get hasText => text.trim().isNotEmpty;

  /// Copie la réponse en remplaçant le texte, le nombre de jetons et/ou la
  /// durée. Chaque champ est conservé tel quel s'il n'est pas fourni.
  AiAnswer copyWith({String? text, int? tokenCount, int? generationTimeMs}) {
    return AiAnswer(
      text: text ?? this.text,
      tokenCount: tokenCount ?? this.tokenCount,
      generationTimeMs: generationTimeMs ?? this.generationTimeMs,
    );
  }
}
