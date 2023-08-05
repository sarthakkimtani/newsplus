import "package:flutter/material.dart";

class SmallLoadingSpinner extends StatelessWidget {
  const SmallLoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 25,
      height: 25,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
