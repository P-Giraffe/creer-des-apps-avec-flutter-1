import 'package:flutter/material.dart';

class Ecran2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Ecran 2"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Retour"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
