import 'package:flutter/material.dart';

class Ecran2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecran 2"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Ecran 2"),
            ElevatedButton(
              onPressed: () {},
              child: Text("Retour"),
            )
          ],
        ),
      ),
    );
  }
}
