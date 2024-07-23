import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../../configs/custom_icons.dart";
import "../small_loading_spinner.dart";
import "../primary_button.dart";
import "../input_field.dart";
import "../../utils/regex_patterns.dart";

enum AuthMode { login, signUp }

class AuthForm extends StatefulWidget {
  final AuthMode mode;
  const AuthForm(this.mode, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _formValues = {"name": "", "email": "", "password": ""};
  var _isLoading = false;

  void showSnackbar({String message = "Something went wrong!"}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message),
      ),
    );
  }

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
      if (widget.mode == AuthMode.login) {
        await _auth.signInWithEmailAndPassword(
          email: _formValues["email"] as String,
          password: _formValues["password"] as String,
        );
      } else {
        await _auth
            .createUserWithEmailAndPassword(
              email: _formValues["email"] as String,
              password: _formValues["password"] as String,
            )
            .then((result) =>
                result.user!.updateDisplayName(_formValues["name"]));
      }
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/tabs");
      }
    } on FirebaseAuthException catch (error) {
      var message = "Could not authenticate. Please enter valid credentials.";
      if (error.message != null) {
        message = error.message as String;
      }
      showSnackbar(message: message);
      Navigator.of(context).pop();
    } catch (error) {
      showSnackbar();
      Navigator.of(context).pop();
    } finally {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = widget.mode == AuthMode.login;
    final buttonChild = isLogin ? const Text("Login") : const Text("Sign Up");
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: mediaQuery.viewInsets.bottom + 10,
        ),
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  splashRadius: 10,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    CustomIcons.close,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    if (!isLogin)
                      InputField(
                        text: "Name",
                        textCaps: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _formValues["name"] = value!;
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 25),
                    InputField(
                      text: "E-mail",
                      isEmail: true,
                      validator: (value) {
                        if (value!.isEmpty || !emailRegex.hasMatch(value)) {
                          return "Enter a valid E-mail";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formValues["email"] = value!;
                      },
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      text: "Password",
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return "Password too short";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formValues["password"] = value!;
                      },
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      widget: _isLoading
                          ? const SmallLoadingSpinner()
                          : buttonChild,
                      width: mediaQuery.size.width * 0.5,
                      onTap: _submit,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
