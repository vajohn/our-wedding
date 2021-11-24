import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/menus/menus.dart';

List<Widget> guestMenu(bool orientation, BuildContext context) {
  if (orientation) {
    return [
      popMenuItem('Menus', null, ['Starter', 'Main', 'Dessert'], context),
      popMenuItem('Drinks', null, ['Bar', 'Orders'], context),

    ];
  } else {
    return [];
  }
}
