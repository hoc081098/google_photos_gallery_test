import 'package:flutter/material.dart';

extension ShowSnackBarBuildContextExtension on BuildContext {
  void showSnackBar(
    String message, [
    Duration duration = const Duration(seconds: 1),
  ]) {
    try {
      final messengerState = ScaffoldMessenger.maybeOf(this);
      if (messengerState == null) {
        return;
      }
      messengerState.hideCurrentSnackBar();
      messengerState.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
        ),
      );
    } catch (_) {}
  }

  void hideCurrentSnackBar() {
    try {
      ScaffoldMessenger.maybeOf(this)?.hideCurrentSnackBar();
    } catch (_) {}
  }
}
