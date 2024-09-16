import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// display the loading indicator
class ViewStateBusyWidget extends StatelessWidget {

  const ViewStateBusyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme.of(context).brightness == Brightness.light
          ? const CupertinoTheme(
              data: CupertinoThemeData(brightness: Brightness.light),
              child: CupertinoActivityIndicator(),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}
