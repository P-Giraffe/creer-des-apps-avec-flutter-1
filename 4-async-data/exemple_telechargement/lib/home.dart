import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("Données chargées");
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
