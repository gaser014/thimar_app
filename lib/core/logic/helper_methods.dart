import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        content: Text(
          message.tr(),
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
MaterialColor? primarySwatch() {
  Color color = const Color(0xFF4C8613);
  return MaterialColor(color.value, {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1.0),
  });
}