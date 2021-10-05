import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(screen: 'Login',),
      body: BackgroundCore(
        child: Center(),
      ),
    );
  }
}
