import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'gradient_icon.dart';

class AuthDialog {
  Future<void> login(BuildContext context) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _textEditingController =
        TextEditingController();
    final TextEditingController _passwordEditingController =
        TextEditingController();
    bool passwordVisibility = false;

    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                height: 175,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _textEditingController,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter email";
                          },
                          decoration: const InputDecoration(
                            hintText: "Please Enter Email",
                          ),
                        ),
                        TextFormField(
                          controller: _passwordEditingController,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter password";
                          },
                          obscureText: !passwordVisibility,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () => setState(() =>
                                  passwordVisibility = !passwordVisibility),
                              icon: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Please Enter password",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Remember me"),
                            Checkbox(
                                value: isChecked,
                                onChanged: (checked) {
                                  setState(() {
                                    isChecked = checked!;
                                  });
                                }),
                          ],
                        )
                      ],
                    )),
              ),
              title: const Text('Login'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const GradientIcon(
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
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.facebookF,
                    size: 22,
                    color: Color(0xFF1778F2),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).replaceNamed('/login-screen');
                  },
                  child: const Text('Login'),
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
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Enter the pin the couple shared with you'),
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
                                    : "Enter pin";
                              },
                              decoration: const InputDecoration(
                                hintText: "Please Enter Pin",
                              ),
                            );
                          }),
                    ],
                  )),
              title: const Text('RSVP'),
              actions: <Widget>[
                InkWell(
                  child: const Text('Cancel   '),
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
                            content: const Text('Incorrect pin provided'),
                            action: SnackBarAction(
                                label: 'Ask the couple ?', onPressed: () {}),
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
