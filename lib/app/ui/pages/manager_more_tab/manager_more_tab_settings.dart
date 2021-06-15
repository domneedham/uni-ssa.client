import 'package:flutter/material.dart';

class ManagerMoreTabSettings extends StatelessWidget {
  const ManagerMoreTabSettings({
    Key? key,
  }) : super(key: key);

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
        )
      ],
    );
  }
}
