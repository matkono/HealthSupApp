import 'package:flutter/material.dart';

class InvertedClipperCircle extends CustomClipper<Path> {
  final double widthClipper;
  final double heightClipper;
  final double radiusClipper;

  InvertedClipperCircle({
    @required this.widthClipper,
    @required this.heightClipper,
    @required this.radiusClipper,
  });

  @override
  Path getClip(Size size) {
    return Path.combine(
        PathOperation.xor,
        Path()
          ..addRect(
            Rect.fromLTWH(0, 0, size.width, size.height),
          ),
        Path()
          ..addOval(Rect.fromCircle(
              center: Offset(size.width - widthClipper, size.height / 2),
              radius: radiusClipper)))
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
