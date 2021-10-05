import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _groomAnimationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    final Animation<double> _groomCurve =
    CurvedAnimation(parent: _groomAnimationController, curve: Curves.elasticOut);
    _groomAnimation = IntTween(begin: 1, end: 6).animate(_groomCurve);
    _groomAnimation.addListener(() => setState(() {}));
    _brideAnimationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    final Animation<double> _brideCurve =
    CurvedAnimation(parent: _brideAnimationController, curve: Curves.elasticOut);
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
              color: Colors.blueAccent,
                child: _groomSide()
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
              color: Colors.pinkAccent,
                child: _brideSide()

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
              color: Colors.blueAccent,
              child: _groomSide()
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
              color: Colors.pinkAccent,
              child: _brideSide(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _groomSide(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
         Text('Groom'),
      ],
    );
  }
  Widget _brideSide(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Bride'),
      ],
    );
  }
}
