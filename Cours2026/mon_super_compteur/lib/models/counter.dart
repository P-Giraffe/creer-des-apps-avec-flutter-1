/// Modèle de données représentant un compteur.
///
/// Classe immuable, indépendante de Flutter et de toute bibliothèque : elle ne
/// décrit que les données et la logique métier qui leur est propre.
class Counter {
  const Counter({this.id, this.name = '', this.value = 0, this.goal});

  /// Identifiant unique attribué par la source de données à la création.
  /// Vaut null tant que le compteur n'a pas encore été sauvegardé.
  final int? id;
  final String name;
  final int value;
  final int? goal;

  /// Vrai lorsqu'un objectif positif est défini et qu'il est atteint.
  bool get isGoalReached => goal != null && goal! > 0 && value >= goal!;

  /// Copie le compteur en remplaçant l'identifiant, le nom et/ou la valeur.
  /// Chacun est conservé tel quel s'il n'est pas fourni. L'objectif est lui
  /// aussi conservé (sa modification éventuelle, qui peut le remettre à null,
  /// se fait par construction directe d'un nouveau Counter).
  Counter copyWith({int? id, String? name, int? value}) {
    return Counter(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      goal: goal,
    );
  }
}
