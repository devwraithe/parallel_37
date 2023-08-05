import 'package:flutter/material.dart';
import 'package:parallel_37/src/presentation/widgets/small_dot.dart';

class BagItem extends StatelessWidget {
  final String name, delivery, price;
  final Function()? action;
  const BagItem({
    Key? key,
    required this.name,
    required this.delivery,
    required this.price,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme.subtitle2?.copyWith(
                  height: 1.26,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    "50% Off",
                    style: textTheme.bodyText1?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Dot(),
                  const SizedBox(width: 10),
                  Text(
                    delivery,
                    style: textTheme.bodyText1?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$$price",
              style: textTheme.subtitle2,
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: action,
              child: Text(
                "Delete",
                style: textTheme.bodyText1?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ],
    );
  }
}
