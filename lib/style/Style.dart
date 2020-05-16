import 'package:flutter/material.dart';

class Style{
  Style._();

  static const String fontName = 'WorkSans';

  static const TextStyle welcomeText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.purple,
  );

  static const TextStyle subWelcomeText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.deepPurpleAccent,
  );

  static const TextStyle subCoinName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Colors.grey,
  );

  static const TextStyle coinName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.purple,
  );
  static const TextStyle bottomText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );



  static const TextStyle errorText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.purple,
  );

  static const TextStyle productCategoryName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.white,
  );
  static const TextStyle variantHeader = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: 12.0,
    color: Colors.black87,
  );
  static const TextStyle variantName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: Colors.black54,
  );
  static const TextStyle taxName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: 12.0,
    color: Colors.blueGrey,
  );
  static const TextStyle variantSubName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Colors.black54,
  );

  static const TextStyle positiveValue = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: Colors.green,
  );
  static const TextStyle negativeValue = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: Colors.red,
  );

}