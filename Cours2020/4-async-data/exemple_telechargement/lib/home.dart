import 'dart:convert';

import 'package:exemples_async_dart/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:collection/collection.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>>? _load;

  initState() {
    super.initState();
    _load = _fetchData();
  }

  Future<List<User>> _fetchData() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> userJsonList = jsonDecode(response.body);
      return userJsonList
          .map((userJsonMap) {
            final user = User.fromJSON(userJsonMap);
            return user.id % 2 == 0 ? user : null;
          })
          .where((element) => element != null)
          .map((e) => e!)
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
        future: _load,
        builder: _buildAsyncContent,
      )),
    );
  }

  Widget _buildAsyncContent(
      BuildContext context, AsyncSnapshot<List<User>> snapshot) {
    final data = snapshot.data;
    if (data != null) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final user = data[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      );
    } else if (snapshot.hasError) {
      return FilledButton(
          onPressed: () {
            setState(() {
              _load = _fetchData();
            });
          },
          child: const Text("Réessayer"));
    } else {
      return CircularProgressIndicator();
    }
  }
}
