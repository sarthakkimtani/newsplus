import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../input_field.dart";
import "../primary_button.dart";
import "../small_loading_spinner.dart";
import "../../providers/member.dart";
import "../../utils/regex_patterns.dart";
import "../../utils/member_exception.dart";

class MemberForm extends StatefulWidget {
  const MemberForm({Key? key}) : super(key: key);

  @override
  State<MemberForm> createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var email = "";
  var _isLoading = false;

  void showSnackbar({String message = "An error occurred!"}) {
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
      await Provider.of<Member>(context, listen: false)
          .checkMemberStatusWithEmail(email);
    } on MemberException catch (error) {
      showSnackbar(message: error.message);
    } catch (error) {
      showSnackbar();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info, size: 60),
            const SizedBox(height: 20),
            Text(
              "To verify your subscription, please enter the email address you used when making the purchase.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16),
            ),
            const SizedBox(height: 30),
            InputField(
              text: "E-mail",
              isEmail: true,
              validator: (value) {
                if (value!.isEmpty || !emailRegex.hasMatch(value)) {
                  return "Enter a valid E-mail";
                }
                return null;
              },
              onSaved: (value) => email = value!,
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              widget: _isLoading
                  ? const SmallLoadingSpinner()
                  : const Text("Submit"),
              width: MediaQuery.of(context).size.width * 0.8,
              onTap: _submit,
            )
          ],
        ),
      ),
    );
  }
}
