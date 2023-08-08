import 'package:flutter/material.dart';

class ImageEtTexte extends StatelessWidget {
  final String image;
  const ImageEtTexte({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image);
  }
}