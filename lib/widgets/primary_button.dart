import "package:flutter/material.dart";

class PrimaryButton extends StatelessWidget {
  final Widget widget;
  final double width;
  final VoidCallback onTap;

  const PrimaryButton({
    Key? key,
    required this.widget,
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
      textStyle: Theme.of(context).textTheme.labelLarge,
      elevation: 0.0,
      fillColor: Colors.black,
      onPressed: onTap,
      child: widget,
    );
  }
}
