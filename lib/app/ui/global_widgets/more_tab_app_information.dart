import 'package:flutter/material.dart';

class MoreTabAppInformation extends StatelessWidget {
  const MoreTabAppInformation({
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
            "App Information",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        AboutListTile(
          applicationVersion: "Version: 0.1",
          aboutBoxChildren: [
            Text("Developed by Dominic Needham for Staffordshire University.")
          ],
          child: Text("About"),
        ),
      ],
    );
  }
}
