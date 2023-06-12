// ignore_for_file: use_key_in_widget_constructors
import "package:flutter/material.dart";

import "./change_password.dart";

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: ListTile(
            leading: Icon(
              Icons.vpn_key,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Change Password",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ChangePassword(),
                ),
              );
            },
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          child: ListTile(
            leading: Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Change Country",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: DropdownButton(items: const [
              DropdownMenuItem(child: Text("IN")),
            ], onChanged: (dynamic val) {}),
            onTap: null,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "${DateTime.now().year} \u00a9 News+",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFa0b0ba)),
        ),
      ],
    );
  }
}
