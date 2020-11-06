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
  var _formkey = GlobalKey<FormState>();
  var _controleurPrenom = TextEditingController();

  _prenomModifie(value) {
    setState(() {
      _prenom = value;
    });
  }

  _confirmerNouveauPrenom() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    }
  }

  @override
  void dispose() {
    _controleurPrenom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text("Prénom : $_prenom"),
            Form(
              key: _formkey,
              child: Row(
                children: [
                  Icon(Icons.person),
                  Expanded(
                    child: TextFormField(
                      controller: _controleurPrenom,
                      //initialValue: "Ted",
                      decoration: InputDecoration(
                          helperText: "Entrez votre prénom",
                          hintText: "Prénom"),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      autofillHints: [AutofillHints.givenName],
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          value.length > 2 ? null : "Prénom trop court",
                      onSaved: _prenomModifie,
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.check),
                      onPressed: _confirmerNouveauPrenom)
                ],
              ),
            )
          ],
        ));
  }
}
