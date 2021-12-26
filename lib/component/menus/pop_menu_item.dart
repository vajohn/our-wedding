import 'package:flutter/material.dart';
import 'package:weddingrsvp/util/router.gr.dart';
import 'package:auto_route/auto_route.dart';

PopupMenuButton popMenuItem(String title, String? description,
    List<String> innerMenu, BuildContext context) {
  return PopupMenuButton(
    onSelected: (menu) => _openRoute(menu, context),
    tooltip: description ?? title,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
        ),
      ),
    ),
    itemBuilder: (context) {
      return innerMenu
          .map(
            (String menu) => PopupMenuItem(
              value: menu,
              child: Text(
                menu,
              ),
            ),
          )
          .toList();
    },
  );
}

void _openRoute(String menu, BuildContext context) {

  switch (menu) {
    case 'Pending':
      context.pushRoute(AdminDashboardRouter(children: [PendingGuests()]));
      break;
    case 'RSVP':
      context.pushRoute(AdminDashboardRouter(children: [ReservedGuests()]));
      // AutoRouter.of(context).pushNamed(GroomGuests.name);
      break;
    case 'Main':
      AutoRouter.of(context).push(AdminDashboardRouter(children: [MainMenu()]));
      break;
    case 'Starter':
      AutoRouter.of(context)
          .push(AdminDashboardRouter(children: [StarterMenu()]));
      break;
    case 'Main':
      AutoRouter.of(context).push(AdminDashboardRouter(children: [MainMenu()]));
      break;
    case 'Starter':
      AutoRouter.of(context)
          .push(AdminDashboardRouter(children: [StarterMenu()]));
      break;
    default:
      AutoRouter.of(context).push(LoginRoute());
  }
}
