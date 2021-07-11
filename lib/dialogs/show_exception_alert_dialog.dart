import 'package:admin/dialogs/show_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(dynamic exception) {
  if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  }
  return exception.toString();
}
