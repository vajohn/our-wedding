import 'package:flutter/material.dart';

import 'pop_menu_item.dart';

List<Widget> adminMenu(bool orientation, BuildContext context) {
  List<PopupMenuButton> menus = [
    popMenuItem('Guests', null, ['Pending', 'RSVP'], context),
    popMenuItem('Menus', null, ['Entree', 'Main', 'Dessert'], context),
    popMenuItem('Drinks', null, ['Bar', 'Orders'], context),
    popMenuItem('Sitting', null, ['Tables', 'Reserved'], context),
  ];
  if (orientation) {
    return menus;
  } else {
    return [
      PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Column(
              children: menus,
            ),
          )
        ],
      )
    ];
  }
}
