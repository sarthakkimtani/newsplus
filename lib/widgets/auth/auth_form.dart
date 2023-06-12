// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../../configs/custom_icons.dart";
import "../small_loading_spinner.dart";
import "../primary_button.dart";

enum AuthMode { login, signUp }

class AuthForm extends StatefulWidget {
  final AuthMode mode;
  const AuthForm(this.mode);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final _formValues = {'name': '', 'email': '', 'password': ''};
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
      if (widget.mode == AuthMode.login) {
        await _auth.signInWithEmailAndPassword(
          email: _formValues['email'] as String,
          password: _formValues['password'] as String,
        );
      } else {
        await _auth
            .createUserWithEmailAndPassword(
              email: _formValues['email'] as String,
              password: _formValues['password'] as String,
            )
            .then((result) =>
                result.user!.updateDisplayName(_formValues['name']));
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
      Navigator.of(context).pop();
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
      Navigator.of(context).pop();
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
          bottom: mediaQuery.viewInsets.bottom,
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
                          _formValues['name'] = value!;
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
                        _formValues['email'] = value!;
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
                        _formValues['password'] = value!;
                      },
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      widget: _isLoading ? SmallLoadingSpinner() : buttonChild,
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

class InputField extends StatelessWidget {
  final String text;
  final bool textCaps;
  final bool isPassword;
  final bool isEmail;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;

  const InputField({
    required this.text,
    required this.validator,
    required this.onSaved,
    this.textCaps = false,
    this.isEmail = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: validator,
      onSaved: onSaved,
      textCapitalization:
          textCaps ? TextCapitalization.words : TextCapitalization.none,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        labelText: text,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFa39b9b),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
