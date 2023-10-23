import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void navigateTo(Widget page) {
      Navigator.of( navigatorKey.currentContext!).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

enum MassageType {
  success,
  failed,
  warning,
}

void showMessage({
  required String message,
  MassageType type = MassageType.failed,
}) {
  print('message is $message');
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: type == MassageType.success
            ? Colors.green
            : type == MassageType.failed
                ? Colors.red
                : Colors.orange,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
