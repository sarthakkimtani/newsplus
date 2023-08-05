import "package:flutter/material.dart";

import "../widgets/auth/auth_buttons.dart";

class AuthScreen extends StatelessWidget {
  static const routeName = "/auth";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            child: Text(
              "Welcome!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Image.asset("assets/images/illustration.png"),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  "Business & Financial News",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 24),
                ),
                const SizedBox(height: 15),
                Text(
                  "Find out what's happening in the Business world all using a single tap.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const AuthButtons(),
        ],
      ),
    );
  }
}
