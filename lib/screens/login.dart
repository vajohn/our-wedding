import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:weddingrsvp/component/components.dart';
import 'package:weddingrsvp/service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailOrPhone = true;
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();

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
                  emailOrPhone ? _emailForm(context) : _phoneForm(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _emailForm(BuildContext context) {
    bool submitted = false;
    bool passwordVisibility = false;

    final TextEditingController _emailEditingController =
        TextEditingController();
    final TextEditingController _passwordEditingController =
        TextEditingController();

    return Container(
      padding: const EdgeInsets.all(18.0),
      width: 400,
      child: Form(
        key: _emailFormKey,
        autovalidateMode: submitted
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
              obscureText: !passwordVisibility,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: () =>
                      setState(() => passwordVisibility = !passwordVisibility),
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
                    onPressed: () {},
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

  _phoneForm(BuildContext context) {
    bool submitted = false;
    bool passwordVisibility = false;
    bool loading = false;

    String? phoneNumber;

    final TextEditingController _passwordEditingController =
    TextEditingController();

    return Container(
      padding: const EdgeInsets.all(18.0),
      width: 400,
      child: Form(
        key: _phoneFormKey,
        autovalidateMode: submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          children: [
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                phoneNumber = number.phoneNumber;
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
                color: Colors.black,
              ),
              initialValue: PhoneNumber(
                isoCode: 'ZW',
              ),
              formatInput: false,
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
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
                  onPressed: () =>
                      setState(() => passwordVisibility = !passwordVisibility),
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
                      setState(() => submitted = true);
                      if (_phoneFormKey.currentState!.validate()) {
                        loading = true;
                        AuthService()
                            .phoneLogin(phoneNumber!,
                            _passwordEditingController.text, context)
                            .then(
                                (response) => setState(() => loading = response));
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
