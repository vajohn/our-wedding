import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weddingrsvp/models/guests.dart';
import 'package:weddingrsvp/service/data.dart';
import 'package:weddingrsvp/util/router.gr.dart';

enum RsvpSide { none, groom, bride }

class SplitRsvp extends StatefulWidget {
  static const String route = '/rsvp';

  const SplitRsvp({Key? key}) : super(key: key);

  @override
  State<SplitRsvp> createState() => _SplitRsvpState();
}

class _SplitRsvpState extends State<SplitRsvp> with TickerProviderStateMixin {
  late AnimationController _groomAnimationController;
  late AnimationController _brideAnimationController;
  late Animation _groomAnimation;
  late Animation _brideAnimation;
  GuestRsvpData? selectedGuest;
  bool guestSelected = false;
  RsvpSide chosenSide = RsvpSide.none;

  @override
  void initState() {
    super.initState();
    _groomAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    final Animation<double> _groomCurve = CurvedAnimation(
        parent: _groomAnimationController, curve: Curves.elasticOut);
    _groomAnimation = IntTween(begin: 1, end: 6).animate(_groomCurve);
    _groomAnimation.addListener(() => setState(() {}));
    _brideAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    final Animation<double> _brideCurve = CurvedAnimation(
        parent: _brideAnimationController, curve: Curves.elasticOut);
    _brideAnimation = IntTween(begin: 1, end: 6).animate(_brideCurve);
    _brideAnimation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 802) {
            return rowView(context);
          } else if (constraints.maxWidth < 801 && constraints.maxWidth > 480) {
            return rowView(context);
          } else {
            return columnView(context);
          }
        },
      ),
    );
  }

  Widget rowView(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: _groomAnimation.value,
          child: InkWell(
            onTap: () {
              if (_groomAnimationController.value != 1) {
                _groomAnimationController.forward();
                _brideAnimationController.reverse();
              } else {
                _groomAnimationController.reverse();
              }
            },
            child: Container(
              decoration: _groomImage(),
              child: _groomSide(_groomAnimationController.value, context),
            ),
          ),
        ),
        Expanded(
          flex: _brideAnimation.value,
          child: InkWell(
            onTap: () {
              if (_brideAnimationController.value != 1) {
                _brideAnimationController.forward();
                _groomAnimationController.reverse();
              } else {
                _brideAnimationController.reverse();
              }
            },
            child: Container(
              decoration: _brideImage(),
              child: _brideSide(_brideAnimationController.value, context),
            ),
          ),
        ),
      ],
    );
  }

  Widget columnView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: _groomAnimation.value,
          child: InkWell(
            onTap: () {
              if (_groomAnimationController.value != 1) {
                _groomAnimationController.forward();
                _brideAnimationController.reverse();
              } else {
                _groomAnimationController.reverse();
              }
            },
            child: Container(
              decoration: _groomImage(),
              child: SizedBox(
                width: 400,
                child: _groomSide(_groomAnimationController.value, context),
              ),
            ),
          ),
        ),
        Expanded(
          flex: _brideAnimation.value,
          child: InkWell(
            onTap: () {
              if (_brideAnimationController.value != 1) {
                _brideAnimationController.forward();
                _groomAnimationController.reverse();
              } else {
                _brideAnimationController.reverse();
              }
            },
            child: Container(
              width: 400,
              decoration: _brideImage(),
              child: _brideSide(_brideAnimationController.value, context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _groomSide(double size, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        size == 1 ? _dropdownSelector(false) : Text(''),
        guestSelected && size == 1 && RsvpSide.groom == chosenSide
            ? ElevatedButton(
                onPressed: () => _sheet(),
                child: Text(
                  'Proceed',
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _brideSide(double size, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        size == 1 ? _dropdownSelector(true) : Text(''),
        guestSelected && size == 1 && RsvpSide.bride == chosenSide
            ? ElevatedButton(
                onPressed: () => _sheet(),
                child: Text(
                  'Proceed',
                ),
              )
            : Container(),
      ],
    );
  }

  BoxDecoration _brideImage() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: const AssetImage('assets/images/bride.jpg'),
        colorFilter: ColorFilter.mode(
          Colors.pink.withOpacity(0.5),
          BlendMode.darken,
        ),
      ),
    );
  }

  BoxDecoration _groomImage() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: const AssetImage('assets/images/groom.jpg'),
        colorFilter: ColorFilter.mode(
          Colors.blue.withOpacity(0.5),
          BlendMode.darken,
        ),
      ),
    );
  }

  _dropdownSelector(bool side) {
    return SizedBox(
      width: 200,
      child: DropdownSearch<GuestRsvpData>(
        showSearchBox: true,
        isFilteredOnline: true,
        showClearButton: true,
        dropdownSearchDecoration: InputDecoration(
          labelText: (side ? 'Bride' : 'Groom') + ' Guest',
          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: OutlineInputBorder(),
        ),
        popupItemBuilder: _listItemView,
        dropdownBuilder: _selectedItemView,
        onFind: (String? filter) async {
          List<GuestRsvpData> response;

          if (filter!.isEmpty) {
            response = await DataService().mockGuestListBySide(side);
          } else {
            List<GuestRsvpData> _toBeFiltered =
                await DataService().mockGuestListBySide(side);
            response = _toBeFiltered
                .where((guest) =>
                    guest.firstName!.toLowerCase().contains(filter.toLowerCase())
                        || guest.surname!.toLowerCase().contains(filter.toLowerCase()))
                .toList();
          }

          return response;
        },
        onChanged: (GuestRsvpData? data) {
          chosenSide = side ? RsvpSide.bride : RsvpSide.groom;
          selectedGuest = data!;
          setState(() {
            guestSelected = true;
          });
        },
      ),
    );
  }

  Widget _selectedItemView(BuildContext context, GuestRsvpData? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: (item.fullName() == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text(
                "No item selected",
              ),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(
                0,
              ),
              title: Text(
                item.fullName() ?? '',
              ),
            ),
    );
  }

  Widget _listItemView(
      BuildContext context, GuestRsvpData? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: ListTile(
        title: Text(
          item?.fullName() ?? '',
        ),
        subtitle: Text(
          item?.additional?.toString() ?? '',
        ),
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.black45,
                Colors.grey,
              ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
          child: CircleAvatar(
            child: Icon(FontAwesomeIcons.user),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Future _sheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                    'Are you ${selectedGuest!.fullName()}, if not cancel and select your name again.'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                    'Please note that once selected your name will be no longer here but checked in'),
              ),
              ListTile(
                leading: new Icon(
                  Icons.cancel_outlined,
                ),
                title: new Text(
                  'Cancel',
                ),
                onTap: () {
                  guestSelected = false;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(
                  FontAwesomeIcons.bookOpen,
                ),
                title: new Text(
                  'RSVP',
                ),
                onTap: () {
                  Navigator.pop(context);
                  //todo add guest
                  context.router.push(DynamicRegistrationRouter());
                },
              ),
            ],
          );
        });
  }
}
