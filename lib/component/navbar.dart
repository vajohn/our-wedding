import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import 'package:weddingrsvp/component/auth_modals.dart';

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

enum LandingStates { login, rsvp }

void selectModal(BuildContext context, LandingStates path) {
  switch (path.index) {
    case 0:
      AuthDialog().login(context);
      break;
    case 1:
      AuthDialog().rsvp(context);
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No such Action'),
        ),
      );
  }
}

class DesktopAppBar extends AppBar {
  DesktopAppBar(BuildContext context, String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () => selectModal(context, LandingStates.values.first),
            ),
            TextButton.icon(
              icon: const Icon(Icons.mark_email_read_outlined),
              label: const Text('RSVP'),
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () => selectModal(context, LandingStates.values.last),
            ),
          ],
          title: _appTitle(screen),
        );
}

class TabAppBar extends AppBar {
  TabAppBar(BuildContext context,String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _appTitle(screen),
          actions: [
            TextButton(
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () => selectModal(context, LandingStates.values.first),
            ),
            TextButton(
              child: const Text(
                'RSVP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () => selectModal(context, LandingStates.values.last),
            ),
          ],
        );
}

class MobileAppBar extends AppBar {
  MobileAppBar(BuildContext context,String screen, {Key? key})
      : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: _appTitle(screen),
          actions: [
            PopupMenuButton<LandingStates>(
              onSelected: (LandingStates result) =>
                  selectModal(context, result),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<LandingStates>>[
                PopupMenuItem<LandingStates>(
                  value: LandingStates.login,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.login),
                      Text('Login'),
                    ],
                  ),
                ),
                PopupMenuItem<LandingStates>(
                  value: LandingStates.rsvp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.mark_email_read_outlined),
                      Text('RSVP'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
}
