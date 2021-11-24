import 'package:flutter/foundation.dart';
import 'package:weddingrsvp/models/user_data.dart';

class CurrentUserData with ChangeNotifier, DiagnosticableTreeMixin {
  UserData? _userData;

  UserData? get userData => _userData;

  void update(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  // // /// Makes `CurrentUser` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('userData', userData));
  }
}
