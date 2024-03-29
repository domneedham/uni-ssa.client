import 'package:flutter/material.dart';

class ManagerStaffTabSearch extends StatelessWidget {
  const ManagerStaffTabSearch({
    Key? key,
    required this.hintText,
    required this.textController,
  }) : super(key: key);

  final String hintText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hintText,
          suffixIcon: const Icon(Icons.search),
        ),
        controller: textController,
      ),
    );
  }
}
