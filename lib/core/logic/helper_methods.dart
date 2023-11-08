import 'package:flutter/material.dart';

var navigatorKey = GlobalKey<NavigatorState>();

void navigateTo(Widget page,{bool removeHistory = false}) {
  Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => !removeHistory,
  );
}

enum MassageType {
  success,
  failed,
  warning,
}enum ProductType {
  favorite,
  custom,
  category,
}

void showMessage({
  required String message,
  MassageType type = MassageType.failed,
}) {
  debugPrint('message is $message');
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
