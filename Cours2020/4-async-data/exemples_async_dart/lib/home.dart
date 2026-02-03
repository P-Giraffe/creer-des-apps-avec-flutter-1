import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _donneesTrouvees = "";
  bool _isLoading = false;

  void _buttonClicked() async {
    setState(() {
      _isLoading = true;
    });
    final String donneesChargees = await _fonctionDeChargement();
    setState(() {
      _donneesTrouvees = donneesChargees;
      _isLoading = false;
    });
  }

  Future<String> _fonctionDeChargement() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final request = Request("GET", url);

    final streamedResponse = await Client().send(request);
    final response = await Response.fromStream(streamedResponse);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: _isLoading ? null : _buttonClicked,
                child: const Text("Lancer le chargement")),
            if (_isLoading)
              const Center(child: LinearProgressIndicator())
            else
              Expanded(
                  child: SingleChildScrollView(child: Text(_donneesTrouvees)))
          ],
        ),
      ),
    );
  }
}
