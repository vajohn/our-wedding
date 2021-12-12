class Invitee {
  String? initialGuest;
  String? initialGuestPassword;
  bool? initialGuestContactType;
  String? initialContact;
  List<AdditionalGuest>? additionalGuests;

  Invitee(
      {this.initialGuest,
      this.initialGuestPassword,
      this.initialGuestContactType,
      this.initialContact,
      this.additionalGuests});

  Invitee.fromJson(Map<String, dynamic> json) {
    initialGuest = json['initialGuest'];
    initialGuestPassword = json['initialGuestPassword'];
    initialGuestContactType = json['initialGuestContactType'];
    initialContact = json['initialContact'];
    if (json['additionalGuests'] != null) {
      additionalGuests = <AdditionalGuest>[];
      json['additionalGuests'].forEach((v) {
        additionalGuests!.add(AdditionalGuest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['initialGuest'] = this.initialGuest;
    data['initialGuestPassword'] = this.initialGuestPassword;
    data['initialGuestContactType'] = this.initialGuestContactType;
    data['initialContact'] = this.initialContact;
    if (this.additionalGuests != null) {
      data['additionalGuests'] =
          this.additionalGuests!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '''InitialGuest {
  initialGuest: $initialGuest,
  initialGuestPassword: $initialGuestPassword,
  initialGuestContactType: ${initialGuestContactType! ? 'phone' : 'email'},
  initialContact: $initialContact,
  additionalGuests: $additionalGuests
}''';
}

class AdditionalGuest {
  String? firstName;
  String? lastName;
  String? contact;
  String? password;
  bool? contactType;
  bool? dependant;

  AdditionalGuest({
    this.firstName,
    this.lastName,
    this.contact,
    this.contactType,
    this.dependant,
    this.password,
  });

  AdditionalGuest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    contact = json['contact'];
    contactType = json['contactType'];
    dependant = json['dependant'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contact'] = this.contact;
    data['contactType'] = this.contactType;
    data['dependant'] = this.dependant;
    data['password'] = this.password;
    return data;
  }

  @override
  String toString() => '''AdditionalGuest {
  firstName: $firstName,
  lastName: $lastName,
  contact: $contact,
  password: $password,
  dependant: $dependant,
  contactType:  ${contactType! ? 'phone' : 'email'},
  }''';
}
