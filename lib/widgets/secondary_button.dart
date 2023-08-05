import "package:flutter/material.dart";

class SecondaryButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onTap;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      enableFeedback: false,
      constraints: BoxConstraints(
        minWidth: width,
        minHeight: 45,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle:
          Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
      elevation: 0.0,
      fillColor: Colors.white,
      onPressed: onTap,
      child: Text(text),
    );
  }
}
