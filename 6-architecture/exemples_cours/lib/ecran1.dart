import 'package:exemples_cours/ecran2.dart';
import 'package:flutter/material.dart';

class Ecran1 extends StatelessWidget {
  final List<String> _personnages = [
    "Ted",
    "Rebecca",
    "Keeley",
    "Roy",
    "Beard",
    "Jamie",
    "Nathan",
    "Higgins"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ted Lasso"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _personnages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_personnages[index]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecran2(
                              title: _personnages[index],
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ecran2(
                              title: "",
                            )));
              },
              child: Text("Aller vers l'Ecran 2"),
            )
          ],
        ),
      ),
    );
  }
}
