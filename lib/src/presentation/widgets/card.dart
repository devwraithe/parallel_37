import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Function()? action;
  final String? image, name, duration, tags, weight, price;
  const CustomCard({
    Key? key,
    this.action,
    this.image,
    this.name,
    this.duration,
    this.tags,
    this.weight,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: action,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: image as Object,
              transitionOnUserGestures: true,
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return RotationTransition(
                  turns: animation.drive(
                    Tween(begin: 0, end: 1),
                  ),
                  filterQuality: FilterQuality.high,
                  child: toHeroContext.widget,
                );
              },
              child: Image.asset(
                image ?? "assets/images/3.png",
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 24),
            Hero(
              tag: name as Object,
              transitionOnUserGestures: true,
              child: Text(
                name ?? "Pizza Name",
                style: textTheme.headline4,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              labelPadding: const EdgeInsets.only(
                top: 3,
                left: 12,
                right: 12,
                bottom: 0,
              ),
              label: Text(
                "$duration Mins",
                style: textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tags ?? "Tags",
                  style: textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 4,
                  width: 4,
                ),
                const SizedBox(width: 12),
                Text(
                  weight ?? "Weight",
                  style: textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              "\$$price",
              style: textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
