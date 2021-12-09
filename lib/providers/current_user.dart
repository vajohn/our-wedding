import 'package:flutter/foundation.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/models/user_data.dart';

class CurrentUserData with ChangeNotifier, DiagnosticableTreeMixin {
  UserData? _userData;
  GuestRsvpData? _guests;
  UserData? get userData => _userData;
  GuestRsvpData? get guestsData => _guests;

  void update(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  void updateGuests(GuestRsvpData? guest){
    _guests = guest;
    notifyListeners();
  }

  // // /// Makes `CurrentUser` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('userData', userData));
  }
}
