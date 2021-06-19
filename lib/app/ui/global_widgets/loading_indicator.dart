import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssa_app/app/ui/utils/platform.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformUtils.isApple
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    );
  }
}
