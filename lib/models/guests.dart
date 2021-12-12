class GuestRsvpListData {
  late List<GuestRsvpData>? guests;

  GuestRsvpListData({required this.guests});

  GuestRsvpListData.fromJson(Map<String, dynamic> json) {
    if (json['guests'] != null) {
      guests = <GuestRsvpData>[];
      json['guests'].forEach((v) {
        guests!.add(new GuestRsvpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guests'] = this.guests!.map((v) => v.toJson()).toList();
    return data;
  }

  GuestRsvpListData.plain(List<GuestRsvpData>? value) {
    if (value != null) {
      guests = value;
    }
  }
}

class GuestRsvpData {
  String? firstName;
  String? surname;
  String? uuid;
  String? side;
  int? additional;
  bool? dependant;
  bool? guardian;

  GuestRsvpData(
      {this.firstName,
      this.surname,
      this.uuid,
      this.side,
      this.additional,
      this.dependant,
      this.guardian});

  GuestRsvpData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    surname = json['surname'];
    uuid = json['uuid'];
    side = json['side'];
    additional = json['additional'];
    dependant = json['dependant'];
    guardian = json['guardian'];
  }

  GuestRsvpData.fromJsonPlusId(Map<String, dynamic> json, String? id) {
    firstName = json['firstName'];
    surname = json['surname'];
    uuid = id;
    side = json['side'];
    additional = json['additional'];
    dependant = json['dependant'];
    guardian = json['guardian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['uuid'] = this.uuid;
    data['side'] = this.side;
    data['additional'] = this.additional;
    data['dependant'] = this.dependant;
    data['guardian'] = this.guardian;
    return data;
  }

  bool isEqual(GuestRsvpData? model) {
    return this.uuid == model?.uuid;
  }

  bool isNameEqual(String name) {
    return this.firstName! + ' ' + this.surname! == name;
  }

  String? fullName() {
    return this.firstName! + ' ' + this.surname!;
  }

  @override
  String toString() {
    return 'GuestRsvpData{firstName: $firstName, surname: $surname, uuid: $uuid, side: $side, additional: $additional, dependant: $dependant, guardian: $guardian}';
  }
}

class GuestReservedData {
  String? firstName;
  String? surname;
  String? uuid;
  String? side;
  List<AdditionalGuestReservedData>? additional;

  GuestReservedData({
    this.firstName,
    this.surname,
    this.uuid,
    this.side,
    this.additional,
  });

  GuestReservedData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    surname = json['surname'];
    uuid = json['uuid'];
    side = json['side'];
    if (json['additional'] != null) {
      additional = <AdditionalGuestReservedData>[];
      json['additional'].forEach((v) {
        additional!.add(AdditionalGuestReservedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['side'] = this.side;
    data['uuid'] = this.uuid;
    if (this.additional != null) {
      data['additional'] = this.additional!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalGuestReservedData {
  String? firstName;
  String? surname;
  String? side;

  AdditionalGuestReservedData({
    this.firstName,
    this.surname,
    this.side,
  });

  AdditionalGuestReservedData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    surname = json['surname'];
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['side'] = this.side;
    return data;
  }
}
