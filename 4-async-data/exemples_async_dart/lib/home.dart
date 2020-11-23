import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _donneesTrouvees = null;
  bool _isLoading = false;
  _buttonClicked() async {
    setState(() {
      _isLoading = true;
    });
    final donneesChargees = await _fonctionDeChargement();
    setState(() {
      _isLoading = false;
      _donneesTrouvees = donneesChargees;
    });
  }

  Future<String> _fonctionDeChargement() async {
    return Future.delayed(Duration(seconds: 3), () => "<3 Purple Giraffe <3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: _buttonClicked, child: Text("Lancer le chargement")),
          if (_donneesTrouvees != null) Text(_donneesTrouvees),
          if (_isLoading) CircularProgressIndicator()
        ],
      ),
    );
  }
}
