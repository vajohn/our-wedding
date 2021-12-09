import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/models/rsvp/invitee.dart';

class ListFieldFormBloc extends FormBloc<String, String> {
  final initialGuest = TextFieldBloc(name: 'initialGuest');
  final initialContact = TextFieldBloc(name: 'initialContact', validators: [FieldBlocValidators.required]);
  final initialGuestContactType =
      BooleanFieldBloc(name: 'initialGuestContactType');

  final additionalGuests =
      ListFieldBloc<MemberFieldBloc, dynamic>(name: 'additionalGuests');
  final GuestRsvpData? guest;

  ListFieldFormBloc(this.guest) : super(isLoading: true) {
    addFieldBlocs(
      fieldBlocs: [
        initialGuest,
        initialContact,
        initialGuestContactType,
        additionalGuests,
      ],
    );


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
        validators: [FieldBlocValidators.required],
      ),
      contactType: BooleanFieldBloc(
        name: 'contactType',
        validators: [FieldBlocValidators.required],
      ),
      dependant: BooleanFieldBloc(
        name: 'dependant',
        validators: [FieldBlocValidators.required],
      ),
    ));
  }

  void removeMember(int index) {
    additionalGuests.removeFieldBlocAt(index);
  }

  @override
  void onSubmitting() async {
    // Without serialization
    final initialGuestData = Invitee(
        initialGuest: initialGuest.value,
        initialContact: initialContact.value,
        initialGuestContactType: initialGuestContactType.value);

    print('initialGuestData');
    print(initialGuestData);

    // With Serialization
    final initialGuestDataV2 = Invitee.fromJson(state.toJson());

    ('initialGuestDataV2');
    print(initialGuestDataV2);

    emitSuccess(
      canSubmitAgain: true,
      successResponse: JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),
    );
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
  BooleanFieldBloc contactType = BooleanFieldBloc(

  );
  BooleanFieldBloc dependant = BooleanFieldBloc(
  );

  MemberFieldBloc({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.contactType,
    required this.dependant,
    String? name,
  }) : super(
            name: name,
            fieldBlocs: [firstName, lastName, contact, contactType, dependant]){
    dependant.onValueChanges(
      onData: (previous, current) async* {

        if (current.value) {
          print('show contact');

        } else {
          print('show remove');

        }
      },
    );
  }
}
