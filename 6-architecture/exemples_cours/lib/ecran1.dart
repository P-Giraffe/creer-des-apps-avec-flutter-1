import 'package:exemples_cours/ecran2.dart';
import 'package:flutter/material.dart';

class Ecran1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecran 1"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Ecran 1"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Ecran2()));
              },
              child: Text("Aller vers l'Ecran 2"),
            )
          ],
        ),
      ),
    );
  }
}
