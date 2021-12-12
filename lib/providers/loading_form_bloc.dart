import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/models/rsvp/invitee.dart';

class ListFieldFormBloc extends FormBloc<String, String> {
  final initialGuest = TextFieldBloc(name: 'initialGuest');
  final initialContact = TextFieldBloc(
      name: 'initialContact',
      validators: [FieldBlocValidators.required, FieldBlocValidators.email]);
  final initialGuestContactType =
      BooleanFieldBloc(name: 'initialGuestContactType');

  final additionalGuests =
      ListFieldBloc<MemberFieldBloc, dynamic>(name: 'additionalGuests');
  final GuestRsvpData? guest;
  int? _additionalCount;

  ListFieldFormBloc(this.guest) : super(isLoading: true) {
    addFieldBlocs(
      fieldBlocs: [
        initialGuest,
        initialContact,
        initialGuestContactType,
        additionalGuests,
      ],
    );
    _additionalCount = this.guest?.additional;
    initialGuestContactType.onValueChanges(onData:
        (BooleanFieldBlocState<dynamic> previous,
            BooleanFieldBlocState<dynamic> current) async* {
      if (current.value) {
        this.initialContact.updateValidators([FieldBlocValidators.required]);
        this.initialContact.updateAsyncValidators([_checkAreaCode]);
      } else {
        this.initialContact.updateAsyncValidators([]);
        this.initialContact.updateValidators(
            [FieldBlocValidators.required, FieldBlocValidators.email]);
      }
    });
  }

  Future<String?> _checkAreaCode(String? phoneNumber) async {
    await Future.delayed(Duration(milliseconds: 500));
    String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (phoneNumber?.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(phoneNumber!)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  void onLoading() async {
    try {
      initialGuest.updateInitialValue(guest!.fullName() ?? '');

      if (guest!.additional! > 0) {
        for (var i = 0; i < guest!.additional!; i++) {
          addMember();
        }
      }
      emitLoaded();
    } catch (e) {
      emitLoadFailed();
    }
  }

  void addMember() {
    additionalGuests.addFieldBloc(MemberFieldBloc(
      name: 'additionalGuest',
      firstName: TextFieldBloc(
        name: 'firstName',
        validators: [FieldBlocValidators.required],
      ),
      lastName: TextFieldBloc(
        name: 'lastName',
        validators: [FieldBlocValidators.required],
      ),
      contact: TextFieldBloc(
        name: 'contact',
      ),
      contactType: BooleanFieldBloc(
        name: 'contactType',
      ),
      dependant: BooleanFieldBloc(
        name: 'dependant',
      ),
    ));
  }

  void removeMember(int index) {
    additionalGuests.removeFieldBlocAt(index);
    _additionalCount = _additionalCount! - 1;
  }

  void addToCount(int val){
    _additionalCount = _additionalCount! + val;
  }
  int? get actualCount => _additionalCount;
  @override
  void onSubmitting() async {
    // Without serialization

    // await Future.delayed(Duration(seconds: 5));
    // final initialGuestData = Invitee(
    //   initialGuest: initialGuest.value,
    //   initialContact: initialContact.value,
    //   initialGuestContactType: initialGuestContactType.value,
    //   additionalGuests:
    //       additionalGuests.value.map<AdditionalGuest>((memberField) {
    //     return AdditionalGuest(
    //         firstName: memberField.firstName.value,
    //         lastName: memberField.lastName.value,
    //         contact: memberField.contact.value,
    //         contactType: memberField.contactType.value);
    //   }).toList(),
    // );
    //
    // print('initialGuestData');
    // print(initialGuestData);

    // With Serialization
    final initialGuestDataV2 = Invitee.fromJson(state.toJson());

    // print('initialGuestDataV2');
    // print(initialGuestDataV2);
    print(
        '${this.guest?.additional} >>> ${initialGuestDataV2.additionalGuests?.length}');
    if (this.guest?.additional != actualCount) {
      print('issues');
      emitDeleteFailed(failureResponse: 'Are you sure');
    } else {
      emitSuccess(
        canSubmitAgain: false,
        successResponse: JsonEncoder.withIndent('    ').convert(
          state.toJson(),
        ),
      );
    }
  }
}

class MemberFieldBloc extends GroupFieldBloc {
  TextFieldBloc firstName = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  TextFieldBloc lastName = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  TextFieldBloc contact = TextFieldBloc();
  BooleanFieldBloc contactType = BooleanFieldBloc();
  BooleanFieldBloc dependant = BooleanFieldBloc();

  MemberFieldBloc({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.contactType,
    required this.dependant,
    String? name,
  }) : super(name: name, fieldBlocs: [
          firstName,
          lastName,
          contact,
          contactType,
          dependant
        ]) {
    dependant.onValueChanges(
      onData: (previous, current) async* {
        if (current.value) {
          this.contact.addValidators(
              [FieldBlocValidators.required, FieldBlocValidators.email]);
        } else {
          this.contact.updateValidators([]);
          this.contact.clear();
        }
      },
    );

    contactType.onValueChanges(onData: (BooleanFieldBlocState<dynamic> previous,
        BooleanFieldBlocState<dynamic> current) async* {
      if (current.value) {
        this.contact.updateValidators([FieldBlocValidators.required]);
        this.contact.updateAsyncValidators([_checkAreaCode]);
      } else {
        this.contact.updateAsyncValidators([]);
        this.contact.updateValidators(
            [FieldBlocValidators.required, FieldBlocValidators.email]);
      }
    });
  }

  Future<String?> _checkAreaCode(String? phoneNumber) async {
    await Future.delayed(Duration(milliseconds: 500));
    String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (phoneNumber?.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(phoneNumber!)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
