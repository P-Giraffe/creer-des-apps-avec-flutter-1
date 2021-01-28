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
              onPressed: () {},
              child: Text("Aller vers l'Ecran 2"),
            )
          ],
        ),
      ),
    );
  }
}
