import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:weddingrsvp/service/auth_service.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  bool emailPasswordVisibility = false;
  bool emailSubmitted = false;
  bool emailLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      width: 400,
      child: Form(
        key: _emailFormKey,
        autovalidateMode: emailSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          children: [
            TextFormField(
              controller: _emailEditingController,
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
              obscureText: !emailPasswordVisibility,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: () =>
                      setState(() => emailPasswordVisibility = !emailPasswordVisibility),
                  icon: Icon(
                    emailPasswordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Please Enter password',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => emailSubmitted = true);
                      if (_emailFormKey.currentState!.validate()) {
                        emailLoading = true;
                        AuthService()
                            .emailLogin(_emailEditingController.text,
                            _passwordEditingController.text, context)
                            .then(
                                (response) => setState(() => emailLoading = response));
                      }
                    },
                    child: Text(
                      'Sign in',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
