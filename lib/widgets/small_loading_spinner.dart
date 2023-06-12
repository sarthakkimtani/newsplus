// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";

class SmallLoadingSpinner extends StatelessWidget {
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
