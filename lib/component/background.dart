import 'package:flutter/material.dart';

class BackgroundCore extends StatefulWidget {
  final Widget child;

  const BackgroundCore({Key? key, required this.child}) : super(key: key);

  @override
  State<BackgroundCore> createState() => _BackgroundCoreState();
}

class _BackgroundCoreState extends State<BackgroundCore> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  responsiveImage(constraints),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: widget.child,
          )
        ],
      );
    });
  }
}

String responsiveImage(constraints) {
  if (constraints.maxWidth > 802) {
    return "assets/images/background-1.jpg";
  } else if (constraints.maxWidth < 801 && constraints.maxWidth > 480) {
    return "assets/images/background-5.jpg";
  } else {
    return "assets/images/background-4.jpg";
  }
}
