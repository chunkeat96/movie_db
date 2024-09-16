import 'package:flutter/material.dart';

import 'view_state_widget.dart';

/// display empty page
class ViewStateEmptyWidget extends StatelessWidget {
  /// error message
  final String? message;

  /// image show on the top list
  final Widget? image;

  /// refresh button message
  final String? buttonText;

  /// call back on press on screen
  final VoidCallback? onPressed;

  const ViewStateEmptyWidget({
    super.key,
    this.image,
    this.message,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image,
      message: message,
      buttonText: buttonText,
    );
  }
}
