import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class DrawerListTile extends StatelessWidget {
  final String name;
  final Icon icon;
  final String routeName;
  final bool isLogout;

  const DrawerListTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.routeName,
    this.isLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = ModalRoute.of(context)!.settings.name == routeName;

    return ListTile(
      onTap: () async {
        if (isSelected) {
          Navigator.of(context).pop();
          return;
        }
        if (isLogout) {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(routeName);
        }
      },
      selected: isSelected,
      selectedTileColor: const Color(0xFF353B46),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      iconColor: isLogout ? Theme.of(context).colorScheme.error : Colors.white,
      selectedColor: Colors.white,
      leading: icon,
      title: Text(
        name,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 18,
              color:
                  isLogout ? Theme.of(context).colorScheme.error : Colors.white,
            ),
      ),
    );
  }
}
