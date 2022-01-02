import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/service/data.dart';

class GuestModals {
  Future<void> addOrEditPendingGuest(
      BuildContext context, GuestRsvpData? guest) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _firstName =
        TextEditingController(text: guest?.firstName ?? '');
    final TextEditingController _surname =
        TextEditingController(text: guest?.surname ?? '');

    bool validationOn = false;
    String sideValue = guest?.side ?? 'bride';
    int additionalValue = guest?.additional ?? 0;
    bool isDependant = guest?.dependant ?? false;
    bool isGuardian = guest?.guardian ?? false;
    double column = 170;

    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(guest != null
                  ? 'Edit ' + guest.fullName()!
                  : 'Add Pending Guest'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: validationOn
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: column,
                            child: TextFormField(
                              controller: _firstName,
                              validator: RequiredValidator(
                                errorText: 'Please enter first name',
                              ),
                              decoration: const InputDecoration(
                                hintText: 'First name',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: column,
                            child: TextFormField(
                              controller: _surname,
                              validator: RequiredValidator(
                                errorText: 'Please enter surname',
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Surname',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: column,
                            child: DropdownButtonFormField<String>(
                              validator: (value) =>
                                  value == null ? 'Please select side' : null,
                              value: sideValue,
                              icon: const Icon(
                                  FontAwesomeIcons.arrowAltCircleDown),
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  sideValue = newValue!;
                                });
                              },
                              items: <String>[
                                'bride',
                                'groom'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: column,
                            child: DropdownButtonFormField<int>(
                              validator: (value) => value == null
                                  ? 'Please select additional guests'
                                  : null,
                              value: additionalValue,
                              icon: const Icon(FontAwesomeIcons.peopleArrows),
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (int? newValue) {
                                setState(() {
                                  additionalValue = newValue!;
                                });
                              },
                              items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: column,
                            child: CheckboxListTile(
                              title: Text(
                                'Dependant',
                              ),
                              activeColor: Colors.grey,
                              checkColor: Colors.white,
                              value: isDependant,
                              onChanged: (bool? value) {
                                setState(() {
                                  isDependant = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: column,
                            child: CheckboxListTile(
                              checkColor: Colors.white,
                              title: Text('Guardian'),
                              activeColor: Colors.grey,
                              value: isGuardian,
                              onChanged: (bool? value) {
                                setState(() {
                                  isGuardian = value!;
                                });
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                guest != null
                    ? ElevatedButton(
                        onPressed: () {
                          DataService().removeFromGuestList(guest.uuid);
                          _formKey.currentState!.reset();
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),),
                )
                    : SizedBox(),
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => validationOn = true);
                    if (_formKey.currentState!.validate()) {
                      GuestRsvpData _g = GuestRsvpData(
                          firstName: _firstName.text,
                          surname: _surname.text,
                          side: sideValue,
                          additional: additionalValue,
                          dependant: isDependant,
                          guardian: isGuardian,
                          uuid: guest?.uuid ?? '');

                      if (guest == null) {
                        DataService().addToGuestList(_g);
                      } else {
                        DataService().editGuestOnList(_g);
                      }

                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    guest == null ? 'Add' : 'Update',
                  ),
                ),
              ],
            );
          });
        });
  }

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.grey;
  }
}
