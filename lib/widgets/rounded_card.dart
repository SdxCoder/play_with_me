import 'package:flutter/material.dart';

class RoundedCardTapable extends StatelessWidget {
  final Function onTap;
  final Function onDoubleTap;
  final Widget content;
  final Color cardColor;
  final double circularRadius;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final double elevation;

  const RoundedCardTapable({
    Key key,
    @required this.onTap,
    @required this.content,
    this.onDoubleTap,
    this.width,
    this.height,
    this.cardColor = Colors.white,
    this.circularRadius = 10.0,
    this.margin,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
            color: cardColor,
            margin: margin,
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circularRadius)),
            child: content),
      ),
    );
  }
}
