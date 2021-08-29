import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows the settings information that are shared for staff and manager more
/// tabs.
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SwitchListTile(
          value: false,
          onChanged: null,
          title: Text('Dark Mode'),
        ),
        ListTile(
          title: const Text('Logout'),
          trailing: const Icon(Icons.logout),
          onTap: () {
            Get.dialog(AlertDialog(
              title: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    // pop the dialog
                    Get.back();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    // pop the dialog
                    Get.back();
                    logout();
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
          },
        )
      ],
    );
  }
}
