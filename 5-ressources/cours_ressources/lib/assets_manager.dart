import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show AssetBundle, ByteData, rootBundle;

class Assets {
  static const String img_logo = "images/logo.png";
  static const String txt_lorem = "text_files/lorem.txt";

  static AssetBundle _bundle({BuildContext context}) {
    AssetBundle bundle;
    if (context != null) {
      bundle = DefaultAssetBundle.of(context);
    } else {
      bundle = rootBundle;
    }
    return bundle;
  }

  static Future<String> loadTextFile(String filename, {BuildContext context}) {
    return _bundle(context: context).loadString(filename);
  }

  static Future<dynamic> loadJSONFromFile(String filename,
      {BuildContext context}) {
    return _bundle(context: context)
        .loadStructuredData(filename, (fileContent) => jsonDecode(fileContent));
  }

  static Future<ByteData> loadDataFromFile(String filname,
      {BuildContext context}) {
    return _bundle(context: context).load(filname);
  }
}
