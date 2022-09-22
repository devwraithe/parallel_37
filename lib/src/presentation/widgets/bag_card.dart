import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BagCard extends StatelessWidget {
  final String? name, image;
  final double? price;
  final Function()? action;
  const BagCard({
    Key? key,
    this.name,
    this.image,
    this.price,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: SizedBox(
        height: 124,
        child: Card(
          elevation: 12,
          shadowColor: const Color.fromARGB(142, 158, 158, 158),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 18, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image ?? "assets/images/2.png",
                      width: 82,
                      height: 82,
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name ?? "Pizza Margarita",
                          style: textTheme.subtitle2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$${price.toString()}",
                          style: textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: action,
                  child: SvgPicture.asset(
                    "assets/icons/trash.svg",
                    color: Colors.red,
                    width: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
