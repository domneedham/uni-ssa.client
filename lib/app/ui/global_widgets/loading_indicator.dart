import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssa_app/app/ui/utils/platform.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformUtils.isApple
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    );
  }
}
