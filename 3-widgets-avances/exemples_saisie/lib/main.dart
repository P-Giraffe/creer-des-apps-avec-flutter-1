import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Accueil(),
    );
  }
}

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var _prenom = "";

  _prenomModifie(value) {
    setState(() {
      _prenom = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text("Prénom : $_prenom"),
            Row(
              children: [
                Icon(Icons.person),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        helperText: "Entrez votre prénom", hintText: "Prénom"),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: [AutofillHints.givenName],
                    keyboardType: TextInputType.name,
                    onChanged: _prenomModifie,
                    onSubmitted: _prenomModifie,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
