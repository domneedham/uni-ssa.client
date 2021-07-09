import 'package:flutter/material.dart';

class StaffOverviewPage extends StatelessWidget {
  const StaffOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Overview"),
      ),
      body: Container(
        child: Center(
          child: Text("Staff overview"),
        ),
      ),
    );
  }
}
