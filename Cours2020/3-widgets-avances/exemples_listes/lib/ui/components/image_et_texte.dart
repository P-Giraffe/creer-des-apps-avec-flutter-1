import 'package:flutter/material.dart';

class ImageEtTexte extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onClick;
  const ImageEtTexte(
      {super.key,
      required this.image,
      required this.title,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onClick();
      },
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
