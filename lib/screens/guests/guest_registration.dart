import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  List<Map<String, dynamic>> _values = [];
  List<bool> dependant = [];
  List<bool> emailOrPhone = [];

  @override
  void initState() {
    dependant = _dependantList(widget.guestRsvpData);
    emailOrPhone = _dependantList(widget.guestRsvpData);
    super.initState();
  }

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
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.guestRsvpData!.additional! + 1,
        itemBuilder: (context, index) {
          return appLayout(desktop(widget.guestRsvpData),
              tab(widget.guestRsvpData), phone(widget.guestRsvpData, index));
        },
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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              index != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Independent',
                        ),
                        Switch(
                          value: dependant[index],
                          onChanged: (value) =>
                              setState(() => dependant[index] = value),
                        ),
                        Text(
                          'Dependent',
                        ),
                      ],
                    )
                  : SizedBox(),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: RequiredValidator(
                        errorText: 'first name is required',
                      ),
                      enabled: index != 0,
                      onChanged: (val) {
                        _onUpdate(index, val, 'first_name');
                      },
                      onSaved: (val) => _onUpdate(index,
                          index == 0 ? data!.firstName : val, 'first_name'),
                      initialValue: index == 0 ? data!.firstName : '',
                    ),
                    TextFormField(
                      enabled: index != 0,
                      validator: RequiredValidator(
                        errorText: 'surname is required',
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Surname',
                      ),
                      onChanged: (val) {
                        _onUpdate(index, val, 'surname');
                      },
                      onSaved: (val) => _onUpdate(
                          index, index == 0 ? data!.surname : val, 'surname'),
                      initialValue: index == 0 ? data!.surname : '',
                    ),
                    !dependant[index]
                        ? emailOrPhone[index]
                            ? InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  _onUpdate(
                                      index, number.phoneNumber, 'phoneNumber');
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                },
                                selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                ),
                                spaceBetweenSelectorAndTextField: 0,
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                initialValue: PhoneNumber(
                                  isoCode: 'ZW',
                                ),
                                formatInput: false,
                                keyboardType: TextInputType.numberWithOptions(
                                  signed: true,
                                  decimal: true,
                                ),
                              )
                            : TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                ),
                                onChanged: (val) {
                                  _onUpdate(index, val, 'email');
                                },
                                validator: MultiValidator([
                                  RequiredValidator(
                                    errorText: 'Email is required',
                                  ),
                                  EmailValidator(
                                    errorText: 'Please enter a valid email',
                                  ),
                                ]),
                              )
                        : SizedBox(),
                    index == 0 && !emailOrPhone[index]
                        ? TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: RequiredValidator(
                              errorText: 'Password is required',
                            ),
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        dependant[index] ?  SizedBox() : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Email',
                              ),
                              Switch(
                                value: emailOrPhone[index],
                                onChanged: (value) =>
                                    setState(() => emailOrPhone[index] = value),
                              ),
                              Text(
                                'Phone',
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (data!.additional! > 0) {
                                print('check the other forms');
                              } else {
                                print('register just one');
                              }
                            } else {
                              // setState(() => formSubmitted[index] = true);
                            }
                          },
                          child: Text('Save'),
                        )
                      ],
                    )
                  ],
                ),
              )
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

  static List<bool> _dependantList(GuestRsvpData? guestRsvpData) {
    List<bool> guests = [false];
    if (guestRsvpData!.additional! > 0) {
      for (var i = 0; i < guestRsvpData.additional!; i++) {
        guests.add(false);
      }
    }
    return guests;
  }
}
//todo registration widget
//todo registration logic => allow for full registration or dependant registration (generate password, require full name, require email or phone
//todo register guest, block registration if guest has additional
//todo check if additional exist
//todo if guest is dependent or not
//todo check if all additional have been registered or marked as dependant
// print(dependant);
// print(_values);
