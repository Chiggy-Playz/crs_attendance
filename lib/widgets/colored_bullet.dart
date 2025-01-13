import 'package:flutter/material.dart';

class ColoredBullet extends StatelessWidget {
  const ColoredBullet({super.key, required this.color, this.size = 32});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: size,
    );
  }
}
