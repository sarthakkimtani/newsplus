// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";

import "./auth_form.dart";
import "../primary_button.dart";
import "../secondary_button.dart";

class AuthButtons extends StatefulWidget {
  @override
  State<AuthButtons> createState() => _AuthButtonsState();
}

class _AuthButtonsState extends State<AuthButtons> {
  void _showSignupSheet(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).canvasColor,
      context: ctx,
      isScrollControlled: true,
      builder: (_) => const AuthForm(AuthMode.signUp),
    );
  }

  void _showLoginSheet(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).canvasColor,
      context: ctx,
      isScrollControlled: true,
      builder: (_) => const AuthForm(AuthMode.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          PrimaryButton(
            widget: const Text("Sign Up"),
            width: mediaQuery.size.width * 0.75,
            onTap: () => _showSignupSheet(context),
          ),
          const SizedBox(height: 15),
          SecondaryButton(
            text: "Log in",
            width: mediaQuery.size.width * 0.75,
            onTap: () => _showLoginSheet(context),
          ),
        ],
      ),
    );
  }
}
