import 'package:flutter/material.dart';

class ColorListTile extends StatelessWidget {
  const ColorListTile({
    super.key,
    required this.color,
    required this.title,
    this.trailing,
    this.subtitle,
    this.onTap,
  });

  final Color color;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        width: 32,
      ),
      title: title,
      trailing: trailing,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}
