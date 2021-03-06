import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  Future<GuestRsvpListData> mockGuestList() async {
    final String response =
        await rootBundle.loadString('assets/json/database.json');
    final data = await json.decode(response);
    return await GuestRsvpListData.fromJson(data);
  }

  Future<GuestRsvpListData> guestList() async {
    List<GuestRsvpData> stuff = [];
    await FirebaseFirestore.instance
        .collection('guests')
        .get()
        .then((value) => value.docs.forEach((element) {
              stuff.add(
                  GuestRsvpData.fromJsonPlusId(element.data(), element.id));
            }));
    return await GuestRsvpListData.plain(stuff);
  }

  Future<List<GuestRsvpData>> mockGuestListBySide(bool brideSide) async {
    try {
      return await this.guestList().then((value) => value.guests!
          .where((guest) => guest.side == (brideSide ? 'bride' : 'groom'))
          .toList());
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
      return [];
    }
  }

  Future<List<GuestRsvpData>> mockGuestFilterBySide(
      bool brideSide, String? search) async {
    try {
      List<GuestRsvpData> data = await this.mockGuestList().then((value) =>
          value.guests!
              .where((guest) => guest.side == (brideSide ? 'bride' : 'groom'))
              .toList());

      return data;
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
      return [];
    }
  }

  void removeFromGuestList(String? uuid) async {
    try {
      await FirebaseFirestore.instance.collection('guests').doc(uuid).delete();
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
    }
  }

  void addToGuestList(GuestRsvpData? guest) async {
    try {
      await FirebaseFirestore.instance.collection('guests').add(guest!.toJson());
    } catch (e) {
      print('Error >>>>>>>>>>>>> $e');
    }
  }
}
