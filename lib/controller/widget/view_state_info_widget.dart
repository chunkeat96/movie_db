import 'package:flutter/material.dart';

import 'view_state_widget.dart';

/// use to show info
class ViewStateInfoWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final String? buttonText;
  final VoidCallback? onPressed;

  const ViewStateInfoWidget({
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
