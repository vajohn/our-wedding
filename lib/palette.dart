
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
     <int, Color>{
      50:  Color(0xfff5f5f5),//10%
      100: Color(0xffe9e9e9),//20%
      200: Color(0xffd9d9d9),//30%
      300: Color(0xffc4c4c4),//40%
      400: Color(0xff9d9d9d),//50%
      500: Color(0xff7b7b7b),//60%
      600:  Color(0xff555555),//70%
      700: Color(0xff434343),//80%
      800: Color(0xff262626),//90%
      900: Color(0xff000000),//100%
    },
  );
}