import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:weddingrsvp/service/auth_service.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool submitted = false;
  bool allowCode = false;
  bool passwordVisibility = false;
  bool loading = false;

  String? phoneNumber;

  final _phoneFormKey = GlobalKey<FormState>();
  final TextEditingController _codeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              isEnabled: !allowCode,
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
            ),
            allowCode ? TextFormField(
              controller: _codeEditingController,
              validator: RequiredValidator(
                errorText: 'Pin is required',
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
                hintText: 'Enter Pin Here',
              ),
            ) : SizedBox(),
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
                            _codeEditingController.text, context)
                            .then(
                                (response) => setState(() => loading = response));
                      }
                    },
                    child: Text(
                      allowCode ? 'Login' : 'Get code',
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
