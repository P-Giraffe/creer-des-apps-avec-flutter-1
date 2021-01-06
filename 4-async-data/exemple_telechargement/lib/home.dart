import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String> _chargerDonnees() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users/1");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Erreur de chargement des données");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FutureBuilder(
        future: _chargerDonnees(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("Erreur de chargement");
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
