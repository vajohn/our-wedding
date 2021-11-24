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
}

class GuestRsvpData {
  String? name;
  String? uuid;
  String? side;
  int? additional;
  bool? dependant;
  bool? guardian;

  GuestRsvpData(
      {this.name,
      this.uuid,
      this.side,
      this.additional,
      this.dependant,
      this.guardian});

  GuestRsvpData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uuid = json['uuid'];
    side = json['side'];
    additional = json['additional'];
    dependant = json['dependant'];
    guardian = json['guardian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
    return this.name == name;
  }
}
