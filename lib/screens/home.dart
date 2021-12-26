import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        screen: '',
      ),
      body: BackgroundCore(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/altLogo2.png',height: 300,),
              Text(
                'Sat 12 March 2022',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
