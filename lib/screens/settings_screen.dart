import "package:flutter/material.dart";

import "../widgets/app_drawer.dart";
import "../widgets/settings/settings_card.dart";
import "../widgets/settings/settings_list.dart";

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          children: [
            SettingsCard(),
            const SizedBox(height: 20),
            SettingsList()
          ],
        ),
      ),
    );
  }
}
