import "package:flutter/material.dart";

class PasswordInputField extends StatefulWidget {
  final String text;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;

  const PasswordInputField({
    Key? key,
    required this.text,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      obscureText: !_passwordVisible,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          splashRadius: 0.1,
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        contentPadding: const EdgeInsets.all(10),
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        labelText: widget.text,
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
