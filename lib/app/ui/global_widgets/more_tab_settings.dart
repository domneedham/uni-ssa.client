import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreTabSettings extends StatelessWidget {
  const MoreTabSettings({
    Key? key,
    required this.logout,
  }) : super(key: key);

  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        SwitchListTile(
          value: false,
          onChanged: null,
          title: Text("Dark Mode"),
        ),
        ListTile(
          title: Text("Logout"),
          trailing: Icon(Icons.logout),
          onTap: () {
            Get.dialog(AlertDialog(
              title: Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () {
                    // pop the dialog
                    Get.back();
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    // pop the dialog
                    Get.back();
                    logout();
                  },
                  child: Text("Yes"),
                ),
              ],
            ));
          },
        )
      ],
    );
  }
}
