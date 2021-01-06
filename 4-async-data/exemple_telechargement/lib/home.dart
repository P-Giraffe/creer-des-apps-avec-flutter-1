import 'dart:convert';

import 'package:exemples_async_dart/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<User> _fetchData() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users/1");
    if (response.statusCode == 200) {
      return User.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("Erreur de chargement des données");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FutureBuilder<User>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.email);
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
