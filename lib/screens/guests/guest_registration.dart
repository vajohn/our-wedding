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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _values = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
        child: _buildRegistration(),
      ),
    );
  }

  _buildRegistration() {
    if (widget.guestRsvpData!.additional! > 0) {
      return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.guestRsvpData!.additional,
          itemBuilder: (context, index) {
            return appLayout(desktop(widget.guestRsvpData), tab(widget.guestRsvpData),
                phone(widget.guestRsvpData, index));
          },
        ),
      );
    } else {
      return appLayout(desktop(widget.guestRsvpData), tab(widget.guestRsvpData),
          phone(widget.guestRsvpData, 0));
    }
  }

  Widget desktop(GuestRsvpData? data) {
    return Card();
  }

  Widget tab(GuestRsvpData? data) {
    return Card();
  }

  Widget phone(GuestRsvpData? data, int index) {
    return Card(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
                enabled: index == 0,
                onChanged: (val) {
                  _onUpdate(index, index == 0 ? data!.firstName : val, 'first_name');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Surname',
                ),
                onChanged: (val) {
                  _onUpdate(index, val, 'surname');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onUpdate(int index, String? val, String field) async {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey("id")) {
        if (map["id"] == index && map['field'] == field) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "field": field,
      "value": val,
    };
    _values.add(json);
  }
}
//todo registration widget
//todo registration logic => allow for full registration or dependant registration (generate password, require full name, require email or phone
//todo register guest, block registration if guest has additional
//todo check if additional exist
//todo if guest is dependent or not
//todo check if all additional have been registered or marked as dependant
