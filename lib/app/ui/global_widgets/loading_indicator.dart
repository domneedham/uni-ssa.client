import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssa_app/app/ui/utils/platform.dart';

/// Shows a loading indicator dependant on the [PlatformUtils] state.
/// Currently is only differentiating between Apple and non-Apple devices.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformUtils.isApple
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
  }
}
