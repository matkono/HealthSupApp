import 'package:flutter/material.dart';

class InvertedClipperRect extends CustomClipper<Path> {
  final double widthClipper;
  final double heightClipper;
  final double radiusClipper;

  InvertedClipperRect({
    @required this.widthClipper,
    @required this.heightClipper,
    @required this.radiusClipper,
  });

  @override
  Path getClip(Size size) {
    return Path.combine(
        PathOperation.difference,
        Path()
          ..addRect(
            Rect.fromLTWH(0, 0, size.width, size.height),
          ),
        Path()
          ..addRect(Rect.fromCenter(
              height: 65,
              width: 420,
              center: Offset(
                  size.width - widthClipper, size.height - heightClipper))))
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
