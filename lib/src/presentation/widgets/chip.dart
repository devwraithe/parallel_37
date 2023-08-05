import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final String title;
  final Color color;
  final Color? titleColor;

  const MyChip({
    Key? key,
    required this.title,
    required this.color,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black,
        ),
      ),
    );
  }
}
