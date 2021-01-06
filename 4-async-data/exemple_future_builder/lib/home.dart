import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String> _fonctionDeChargement() async {
    return Future.delayed(Duration(seconds: 3), () => "<3 Purple Giraffe <3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("Erreur de chargement");
          } else {
            return CircularProgressIndicator();
          }
        },
        future: _fonctionDeChargement(),
      )),
    );
  }
}
