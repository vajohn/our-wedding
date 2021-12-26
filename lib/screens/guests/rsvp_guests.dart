import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';

class ReservedGuests extends StatelessWidget {
  const ReservedGuests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
          child: Center(child: Text('groom'))
      ),
    );
  }
}
