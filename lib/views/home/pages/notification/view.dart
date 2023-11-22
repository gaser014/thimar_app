import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:themar/core/design/unit/app_string.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(DataString.notification.tr()),
      ),
    );
  }
}
