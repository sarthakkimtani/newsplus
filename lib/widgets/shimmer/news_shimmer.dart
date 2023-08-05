import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
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
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: const Color(0xFFa0b0ba),
                width: double.infinity,
                height: 180,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFa0b0ba),
              ),
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                height: 20,
                color: Color(0xFFa0b0ba),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFa0b0ba),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: 220,
                  height: 90,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 90,
                    height: 90,
                    color: const Color(0xFFa0b0ba),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
