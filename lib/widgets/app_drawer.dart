import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import '../configs/custom_icons.dart';
import '../widgets/drawer_list_tile.dart';

class AppDrawer extends StatelessWidget {
  final userName = FirebaseAuth.instance.currentUser!.displayName;

  AppDrawer({Key? key}) : super(key: key);

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords > names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF191c21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, left: 30),
            width: double.infinity,
            height: 200,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text(
                    getInitials(userName!),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  userName as String,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: const Column(
              children: [
                DrawerListTile(
                  name: "Home",
                  icon: Icon(CustomIcons.home),
                  routeName: "/tabs",
                ),
                DrawerListTile(
                  name: "Settings",
                  icon: Icon(Icons.settings),
                  routeName: "/settings",
                ),
                DrawerListTile(
                  name: "Logout",
                  icon: Icon(
                    Icons.logout,
                  ),
                  routeName: "/auth",
                  isLogout: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
