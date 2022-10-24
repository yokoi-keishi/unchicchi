import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventMarker extends StatelessWidget {
  const EventMarker({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        child: const FaIcon(
          FontAwesomeIcons.poop,
          size: 13,
          color: Colors.brown,
        ));
  }
}
