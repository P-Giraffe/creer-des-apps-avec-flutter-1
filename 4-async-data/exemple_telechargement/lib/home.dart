import 'dart:convert';

import 'package:exemples_async_dart/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> _fetchData() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");
    if (response.statusCode == 200) {
      final List userJsonList = jsonDecode(response.body);
      return userJsonList
          .map((userJsonMap) => User.fromJSON(userJsonMap))
          .toList();
    } else {
      throw Exception("Erreur de chargement des données");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FutureBuilder<List<User>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, userIndex) {
                  final user = snapshot.data[userIndex];
                  return Text(user.name);
                });
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
