import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final String text;
  final bool textCaps;
  final bool isPassword;
  final bool isEmail;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;

  const InputField({
    Key? key,
    required this.text,
    required this.validator,
    required this.onSaved,
    this.textCaps = false,
    this.isEmail = false,
    this.isPassword = false,
  }) : super(key: key);

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
