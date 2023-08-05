import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class MarketsShimmer extends StatelessWidget {
  const MarketsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFa0b0ba),
                borderRadius: BorderRadius.circular(4),
              ),
              width: 150,
              height: 25,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => const Column(
                  children: [
                    ListShimmer(),
                    SizedBox(height: 20),
                  ],
                ),
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListShimmer extends StatelessWidget {
  const ListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: const Color(0xFFa0b0ba),
            width: double.infinity,
            height: 18,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: const Color(0xFFa0b0ba),
            width: 200,
            height: 18,
          ),
        ),
      ],
    );
  }
}
