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
  var _listeUrlImages = <String>[
    "https://www.cesarsway.com/wp-content/uploads/2015/06/puppy-checklist.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSh_rmg-Zg5nmPaCdo_DrfkwQt1lL1qAlUiLQ&usqp=CAU",
    "https://hips.hearstapps.com/countryliving.cdnds.net/17/47/1511194376-cavachon-puppy-christmas.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTWApY7vpCoiyrYKL1FUsfNDwYUSNPTG5TZlQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTxuKzNrLE9lg7GzazWTob721eXrPKzPM8x3A&usqp=CAU",
    "https://www.cesarsway.com/wp-content/uploads/2015/06/puppy-checklist.png",
  ];

  Widget _generateurDeLigne(BuildContext context, int numeroDeLigne) {
    return Image.network(_listeUrlImages[numeroDeLigne]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: _listeUrlImages.length,
            itemBuilder: _generateurDeLigne));
  }
}
