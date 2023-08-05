import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreCardShimmer extends StatelessWidget {
  final int? itemCount;
  const StoreCardShimmer({Key? key, this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 264,
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return const SizedBox(height: 220);
          },
        ),
      ),
    );
  }
}
