import 'package:flutter/material.dart';

class Ecran2 extends StatelessWidget {
  final String title;

  const Ecran2({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(title),
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
