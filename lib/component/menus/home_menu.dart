import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weddingrsvp/util/router.gr.dart';

import '../auth_modals.dart';

List<Widget> homeMenu(bool orientation, BuildContext context) {
  if (orientation) {
    return [
      TextButton(
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onPressed: () => _selectModal(context, LandingStates.values.first),
      ),
      TextButton(
        child: const Text(
          'RSVP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onPressed: () => _selectModal(context, LandingStates.values.last),
      ),
    ];
  } else {
    return [
      PopupMenuButton<LandingStates>(
        onSelected: (LandingStates result) => _selectModal(context, result),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<LandingStates>>[
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
    ];
  }
}

enum LandingStates { login, rsvp }

void _selectModal(BuildContext context, LandingStates path) {
  switch (path.index) {
    case 0:
      AutoRouter.of(context).push(LoginRoute());
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


