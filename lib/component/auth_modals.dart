import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:weddingrsvp/service/auth_service.dart';

import 'gradient_icon.dart';

class AuthDialog {
  Future<void> login(BuildContext context) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _textEditingController =
        TextEditingController();
    final TextEditingController _passwordEditingController =
        TextEditingController();
    bool passwordVisibility = false;
    bool submitted = false;
    bool loading = false;

    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);

    AuthService().verifyAndLogin(context);

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: EmailValidator(
                          errorText: 'Please enter a valid email',
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Please Enter Email',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordEditingController,
                        validator: RequiredValidator(
                          errorText: 'password is required',
                        ),
                        obscureText: !passwordVisibility,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            onPressed: () => setState(
                                () => passwordVisibility = !passwordVisibility),
                            icon: Icon(
                              passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Please Enter password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: const Text(
                'Login',
              ),
              actions: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: loading ? CircularProgressIndicator.adaptive() : null,
                ),
                IconButton(
                  onPressed: () {
                    loading = true;
                    AuthService()
                        .signInWithGoogle(context)
                        .then(
                            (response) => setState(() => loading = response));
                  },                  icon: const GradientIcon(
                    material: true,
                    size: 20,
                    icon: FontAwesomeIcons.google,
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    loading = true;
                    AuthService()
                        .signInWithFacebook(context)
                        .then(
                            (response) => setState(() => loading = response));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.facebookF,
                    size: 22,
                    color: Color(
                      0xFF1778F2,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() => submitted = true);
                    if (_formKey.currentState!.validate()) {
                      loading = true;
                      AuthService()
                          .emailLogin(_textEditingController.text,
                              _passwordEditingController.text, context)
                          .then(
                              (response) => setState(() => loading = response));
                    }
                  },
                  child: const Text(
                    'Login',
                  ),
                )
              ],
            );
          });
        });
  }

  Future<void> rsvp(BuildContext context) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _textEditingController =
        TextEditingController();
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Enter the pin the couple shared with you',
                        ),
                        AnimatedBuilder(
                            animation: _textEditingController,
                            builder: (context, _) {
                              return TextFormField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  return value!.isNotEmpty || value.length > 3
                                      ? null
                                      : 'Enter pin';
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Please Enter Pin',
                                ),
                              );
                            }),
                      ],
                    )),
              ),
              title: const Text(
                'RSVP',
              ),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'Cancel   ',
                  ),
                  onTap: () {
                    _formKey.currentState!.reset();
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_textEditingController.value.text != '0607') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Incorrect pin provided',
                            ),
                            action: SnackBarAction(
                              label: 'Ask the couple ?',
                              onPressed: () {},
                            ),
                          ),
                        );
                      } else {
                        // Navigator.of(context).pushReplacementNamed(
                        //   SplitRsvp.route,
                        // );
                        AutoRouter.of(context).pushNamed('/split-rsvp');
                      }
                    }
                  },
                  child: const Text('Check'),
                ),
              ],
            );
          });
        });
  }
}
