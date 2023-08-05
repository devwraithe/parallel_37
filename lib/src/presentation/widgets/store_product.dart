import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parallel_37/src/presentation/widgets/chip.dart';

class StoreProduct extends StatelessWidget {
  final String name, image, price;
  final Function()? action, addToCart;
  const StoreProduct(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      this.action,
      this.addToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: action,
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => const Center(
                        child: CupertinoActivityIndicator(
                      color: Colors.orange,
                    )),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: addToCart,
                    child: MyChip(
                      title: "Add to Cart",
                      color: Colors.white.withOpacity(0.94),
                      titleColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
