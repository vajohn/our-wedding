import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';
import 'package:weddingrsvp/screens/auth/email_login.dart';
import 'package:weddingrsvp/screens/auth/phone_login.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailOrPhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        screen: 'Login',
      ),
      body: BackgroundCore(
        child: Center(
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Phone',
                        ),
                        Switch(
                          value: emailOrPhone,
                          onChanged: (value) {
                            setState(() {
                              emailOrPhone = value;
                            });
                          },
                        ),
                        Text(
                          'Email',
                        ),
                      ]),
                  emailOrPhone ? EmailLogin() : PhoneLogin()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
