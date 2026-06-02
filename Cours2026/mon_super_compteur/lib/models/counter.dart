/// Modèle de données représentant un compteur.
///
/// Classe immuable, indépendante de Flutter et de toute bibliothèque : elle ne
/// décrit que les données et la logique métier qui leur est propre.
class Counter {
  const Counter({this.name = '', this.value = 0, this.goal});

  final String name;
  final int value;
  final int? goal;

  /// Vrai lorsqu'un objectif positif est défini et qu'il est atteint.
  bool get isGoalReached => goal != null && goal! > 0 && value >= goal!;

  /// Copie le compteur en remplaçant le nom et/ou la valeur. L'objectif est
  /// conservé tel quel (sa modification éventuelle, qui peut le remettre à null,
  /// se fait par construction directe d'un nouveau Counter).
  Counter copyWith({String? name, int? value}) {
    return Counter(
      name: name ?? this.name,
      value: value ?? this.value,
      goal: goal,
    );
  }
}
