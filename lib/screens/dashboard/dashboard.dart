import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        screen: 'Dashboard',
      ),
      body: BackgroundCore(
        child: AutoRouter() ,
      ),
    );
  }
}
