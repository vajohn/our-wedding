import 'package:flutter/material.dart';
import 'package:weddingrsvp/component/components.dart';
import 'package:weddingrsvp/models/guests.dart';

class GuestRegistration extends StatefulWidget {
  final GuestRsvpData? guestRsvpData;

  const GuestRegistration({Key? key, required this.guestRsvpData})
      : super(key: key);

  @override
  _GuestRegistrationState createState() => _GuestRegistrationState();
}

class _GuestRegistrationState extends State<GuestRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.guestRsvpData!.name ?? ''),
            Text(widget.guestRsvpData!.additional.toString()),
          ],
        ),
      ),
    );
  }
}
//todo registration widget
//todo registration logic => allow for full registration or dependant registration (generate password, require full name, require email or phone
//todo register guest, block registration if guest has additional
//todo check if additional exist
//todo if guest is dependent or not
//todo check if all additional have been registered or marked as dependant