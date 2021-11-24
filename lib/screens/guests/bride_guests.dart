import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/background.dart';

class BrideGuests extends StatelessWidget {
  const BrideGuests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
        child: AutoRouter() ,
      ),
    );
  }
}
