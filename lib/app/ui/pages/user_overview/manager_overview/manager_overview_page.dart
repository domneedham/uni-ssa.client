import 'package:flutter/material.dart';

class ManagerOverviewPage extends StatelessWidget {
  const ManagerOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Overview"),
      ),
      body: Container(
        child: Center(
          child: Text("Manager overview"),
        ),
      ),
    );
  }
}
