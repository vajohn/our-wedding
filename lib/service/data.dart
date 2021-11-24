import 'dart:convert';

import 'package:weddingrsvp/models/guests.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  Future<GuestRsvpListData> mockGuestList() async {
    final String response =
        await rootBundle.loadString('assets/json/database.json');
    final data = await json.decode(response);
    return await GuestRsvpListData.fromJson(data);
  }

  Future<List<GuestRsvpData>> mockGuestListBySide(
      bool brideSide) async {
    try {
      List<GuestRsvpData> data = await this.mockGuestList().then((value) => value.guests!
          .where((guest) => guest.side == (brideSide ? 'bride' : 'groom'))
          .toList());
      return data;
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
      return [];
    }
  }

  Future<List<GuestRsvpData>> mockGuestFilterBySide(
      bool brideSide, String? search) async {
    try {
      List<GuestRsvpData> data = await this.mockGuestList().then((value) => value.guests!
          .where((guest) => guest.side == (brideSide ? 'bride' : 'groom'))
          .toList());


      return data;
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
      return [];
    }
  }
}
