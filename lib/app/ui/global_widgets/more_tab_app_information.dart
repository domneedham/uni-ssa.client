import 'package:flutter/material.dart';

class MoreTabAppInformation extends StatelessWidget {
  const MoreTabAppInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'App Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        AboutListTile(
          applicationVersion: 'Version: 1.0',
          aboutBoxChildren: [
            Text('Developed by Dominic Needham for Staffordshire University.')
          ],
          child: Text('About'),
        ),
      ],
    );
  }
}
