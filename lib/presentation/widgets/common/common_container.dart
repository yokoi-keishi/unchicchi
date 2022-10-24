import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(10),
    this.margin = const EdgeInsets.all(20),
    this.radius = 10,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        boxShadow: const [BoxShadow(offset: Offset(0, 2))],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: child,
    );
  }
}
