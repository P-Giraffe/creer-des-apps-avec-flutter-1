class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
  User.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"];
}
