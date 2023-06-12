// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import "./password_input_field.dart";
import "../primary_button.dart";
import "../small_loading_spinner.dart";

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;
  final _passwords = {"old": "", "new": ""};
  var _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      final AuthCredential authCredential = EmailAuthProvider.credential(
        email: user!.email as String,
        password: _passwords["old"] as String,
      );
      await user!.reauthenticateWithCredential(authCredential);
      await user!.updatePassword(_passwords["new"] as String);
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      var message = "An error occured.";
      if (error.message != null) {
        message = error.message as String;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(message),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("Something went wrong!"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState!.reset();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text("Password Changed Successfully!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Text(
              "Update your password",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: Text(
              "Please enter your existing password and your new password",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PasswordInputField(
                    text: "Current Password",
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Password too short";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwords["old"] = value as String;
                    },
                  ),
                  const SizedBox(height: 30),
                  PasswordInputField(
                    text: "New Password",
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Password too short";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwords["new"] = value as String;
                    },
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    widget: _isLoading
                        ? SmallLoadingSpinner()
                        : const Text("Change Password"),
                    width: double.infinity - 20,
                    onTap: _submit,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
