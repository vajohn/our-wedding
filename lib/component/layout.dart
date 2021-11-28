import 'package:flutter/material.dart';

Widget appLayout(desktop,tab,phone){
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 802) {
        return desktop;
      } else if (constraints.maxWidth < 801 && constraints.maxWidth > 480) {
        return tab;
      } else {
        return phone;
      }
    },
  );
}