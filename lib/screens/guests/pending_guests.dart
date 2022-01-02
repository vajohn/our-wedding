import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weddingrsvp/component/components.dart';
import 'package:weddingrsvp/component/guest_modals.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/service/data.dart';
import 'package:weddingrsvp/util/excelToJson.dart';
import 'package:weddingrsvp/util/extensions.dart';
import 'dart:developer' as dev;

class PendingGuests extends StatefulWidget {
  const PendingGuests({Key? key}) : super(key: key);

  @override
  State<PendingGuests> createState() => _PendingGuestsState();
}

class _PendingGuestsState extends State<PendingGuests> {
  late Future<GuestRsvpListData> _func;

  @override
  void initState() {
    _func = fetchGuest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundCore(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                new Wrap(
                  spacing: 15.0,
                  // gap between adjacent chips
                  runSpacing: 15.0,
                  // gap between lines
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: addByExcel,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add by Excel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              WeddingIcons.excel,
                              color: Colors.white,
                            )
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () =>
                            GuestModals().addOrEditPendingGuest(context, null),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black54),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add a Guest',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              FontAwesomeIcons.userPlus,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 400,
                  child: ListView(children: <Widget>[
                    FutureBuilder<GuestRsvpListData>(
                      future: _func,
                      builder: (BuildContext context,
                          AsyncSnapshot<GuestRsvpListData> snapshot) {
                        if (snapshot.hasData) {
                          return LayoutBuilder(builder: (context, constraints) {
                            return SingleChildScrollView(
                              scrollDirection: constraints.maxWidth > 480
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'ID',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Additional',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Side',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Dependant',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Guardian',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: _guestRow(snapshot.data),
                              ),
                            );
                          });
                        } else if (snapshot.hasError) {
                          return Text(
                            'No guests available',
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _guestRow(GuestRsvpListData? guests) {
    List<DataRow> _g = [];

    guests?.guests?.forEach((GuestRsvpData guest) {
      _g.add(
        DataRow(
          onSelectChanged: (_) =>
              GuestModals().addOrEditPendingGuest(context, guest),
          cells: [
            DataCell(
              Text(
                guest.uuid!,
              ),
            ),
            DataCell(
              Text(
                guest.firstName! + ' ' + guest.surname!,
              ),
            ),
            DataCell(
              Center(
                widthFactor: 12.0,
                child: Text(
                  guest.additional!.toString(),
                ),
              ),
            ),
            DataCell(
              Text(
                guest.side!.capitalize(),
              ),
            ),
            DataCell(
              Center(
                widthFactor: 3.0,
                child: Icon(
                  guest.dependant!
                      ? FontAwesomeIcons.checkSquare
                      : FontAwesomeIcons.minusSquare,
                  color: guest.dependant! ? Colors.green : Colors.redAccent,
                ),
              ),
            ),
            DataCell(
              Center(
                widthFactor: 3.0,
                child: Icon(
                  guest.guardian!
                      ? FontAwesomeIcons.checkSquare
                      : FontAwesomeIcons.minusSquare,
                  color: guest.guardian! ? Colors.green : Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    });

    return _g;
  }

  Future<GuestRsvpListData> fetchGuest() async {
    return await DataService().guestList();
  }

  void addByExcel() async {
    excelToJson()
        .then((excelSheet) => excelSheet!.forEach((rowData) =>
            DataService().addToGuestList(GuestRsvpData.fromJsonLink(rowData))))
        .catchError((error) => dev.log('$error'));
  }

  perform(Object) async {}
}
