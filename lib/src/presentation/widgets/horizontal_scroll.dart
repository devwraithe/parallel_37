import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final int itemCount;
  final Widget Function(dynamic, int) items;
  const HorizontalScroll({
    Key? key,
    required this.items,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 264,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: itemCount,
        itemBuilder: items,
      ),
    );
  }
}
