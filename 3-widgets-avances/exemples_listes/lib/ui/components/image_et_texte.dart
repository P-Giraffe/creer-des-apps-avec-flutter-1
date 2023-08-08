import 'package:flutter/material.dart';

class ImageEtTexte extends StatelessWidget {
  final String image;
  final String title;
  const ImageEtTexte({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          )),
      title: Text(title),
    );
  }
}
