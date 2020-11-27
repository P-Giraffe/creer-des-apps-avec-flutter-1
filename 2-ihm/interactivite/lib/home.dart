import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _score = 0;
  var _afficherLeBoutonTexte = true;
  _plusButtonClicked() {
    setState(() {
      _score = _score + 1;
    });
  }

  _toggleButtonClicked() {
    setState(() {
      _afficherLeBoutonTexte = !_afficherLeBoutonTexte;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Score : $_score"),
          IconButton(
              icon: Icon(Icons.plus_one),
              iconSize: 50,
              onPressed: _plusButtonClicked),
          ElevatedButton.icon(
              onPressed: _plusButtonClicked,
              icon: Icon(Icons.plus_one),
              label: Text("Ajouter un point")),
          OutlineButton(
            onPressed: _toggleButtonClicked,
            child: Text((_afficherLeBoutonTexte ? "Masquer" : "Afficher") +
                " le bouton texte"),
          ),
          if (_afficherLeBoutonTexte)
            TextButton(
              onPressed: _plusButtonClicked,
              child: Text("Ajouter un point"),
            )
        ],
      ),
    );
  }
}
