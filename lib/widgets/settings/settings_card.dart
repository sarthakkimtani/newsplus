// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class SettingsCard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords > names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      height: 130,
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user!.displayName as String,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  user!.email as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                getInitials(user!.displayName as String),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
