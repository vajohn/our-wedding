import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        screen: 'Admin',
      ),
      body: BackgroundCore(
        child: AutoRouter() ,
      ),
    );
  }
}
