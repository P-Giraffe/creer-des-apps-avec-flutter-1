import 'package:demo/ui/components/image_et_texte.dart';
import 'package:extension_flutter_tools/extension_flutter_tools.dart';
import 'package:flutter/material.dart';

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

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: _AccueilBody(),
        ));
  }
}

class _AccueilBody extends StatefulWidget {
  const _AccueilBody({super.key});

  @override
  State<_AccueilBody> createState() => __AccueilBodyState();
}

class __AccueilBodyState extends State<_AccueilBody> {
  var _listeUrlImages = <String>[
    "https://www.cesarsway.com/wp-content/uploads/2015/06/puppy-checklist.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSh_rmg-Zg5nmPaCdo_DrfkwQt1lL1qAlUiLQ&usqp=CAU",
    "https://hips.hearstapps.com/countryliving.cdnds.net/17/47/1511194376-cavachon-puppy-christmas.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTWApY7vpCoiyrYKL1FUsfNDwYUSNPTG5TZlQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTxuKzNrLE9lg7GzazWTob721eXrPKzPM8x3A&usqp=CAU"
  ];

  Widget _generateurDeLigne(BuildContext context, int numeroDeLigne) {
    final urlImage = _listeUrlImages[numeroDeLigne];
    return ImageEtTexte(
      image: urlImage,
      title: "Toutou $numeroDeLigne",
      onClick: () {
        print("Clic sur le toutou $numeroDeLigne");
      },
    );
  }

  void _supprimerToutesLesPhotos() {
    setState(() {
      _listeUrlImages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: _listeUrlImages.length,
              itemBuilder: _generateurDeLigne),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConfirmWrapper(
              confirmationQuestionText:
                  "Voulez vous vraiment supprimer tous ces chiots si mignons ?",
              confirmationYesText: "Oui, les supprimer",
              confirmationNoText: "Non, il faut les sauver",
              childBuilder: (onTap) => FilledButton(
                  onPressed: onTap,
                  child: const Text("Supprimer toutes les photos")),
              onConfirm: _supprimerToutesLesPhotos),
        )
      ],
    );
  }
}
