// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String imgSrc;
  final String text;

  const ImageBanner({required this.imgSrc, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            imgSrc,
            width: 250,
            height: 250,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
