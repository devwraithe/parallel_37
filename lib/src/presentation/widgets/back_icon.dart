import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconImport extends StatelessWidget {
  final Color? color;
  final String? icon;
  final double? size;
  final Function()? action;
  const IconImport({
    Key? key,
    this.icon,
    this.size,
    this.color,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: SvgPicture.asset(
        icon ?? "assets/icons/arrow-left.svg",
        width: size ?? 28,
        color: color ?? Colors.black,
      ),
    );
  }
}
