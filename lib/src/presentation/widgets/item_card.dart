import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parallel_37/src/presentation/views/store_details.dart';
import 'package:parallel_37/src/presentation/widgets/chip.dart';
import 'package:parallel_37/src/presentation/widgets/shimmers/store_card_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ItemCard extends StatelessWidget {
  final String title, image;
  final String chip, attachment;
  final Function()? action;
  const ItemCard({
    Key? key,
    required this.title,
    required this.image,
    required this.chip,
    required this.attachment,
    required this.action,
  }) : super(key: key);

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
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: MyChip(
                    title: chip,
                    color: Colors.white.withOpacity(0.94),
                    titleColor: Colors.black,
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
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  MyChip(
                    title: attachment,
                    color: Colors.orange,
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
