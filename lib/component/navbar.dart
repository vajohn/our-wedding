import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:weddingrsvp/component/menus/menus.dart';
import 'package:weddingrsvp/providers/current_user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String screen;

  const Navbar({Key? key, required this.screen})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 802) {
          return DesktopAppBar(context, widget.screen);
        } else if (constraints.maxWidth < 801 && constraints.maxWidth > 480) {
          return TabAppBar(context, widget.screen);
        } else {
          return MobileAppBar(context, widget.screen);
        }
      },
    );
  }
}

Row _appTitle(String screen) {
  return Row(
    children: [
      const FaIcon(FontAwesomeIcons.dove),
      const SizedBox(
        width: 8,
      ),
      Text(screen == '' ? 'Faizal & Stacey' : screen),
      const SizedBox(
        width: 8,
      ),
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: const FaIcon(FontAwesomeIcons.dove),
      ),
    ],
  );
}

List<Widget> selectMenu(bool orientation, String menu, BuildContext context) {
  if(context.watch<CurrentUserData>().userData != null){
    print('>>>>>> ${context.watch<CurrentUserData>().userData!.roles.toList()}');

  }
  switch (menu) {
    case 'Login':
      return [];
    case 'Dashboard':
      return guestMenu(orientation, context);
    case 'Admin':
      return adminMenu(orientation, context);
    default:
      return homeMenu(orientation, context);
  }
}

class DesktopAppBar extends AppBar {
  DesktopAppBar(BuildContext context, String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: selectMenu(true, screen, context),
          title: _appTitle(screen),
          automaticallyImplyLeading: !kIsWeb,
        );
}

class TabAppBar extends AppBar {
  TabAppBar(BuildContext context, String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _appTitle(screen),
          actions: selectMenu(true, screen, context),
    automaticallyImplyLeading: !kIsWeb,
  );
}

class MobileAppBar extends AppBar {
  MobileAppBar(BuildContext context, String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _appTitle(screen),
          actions: selectMenu(false, screen, context),
          automaticallyImplyLeading: !kIsWeb,
  );
}
