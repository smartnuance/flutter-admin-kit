import 'package:admin/common_widgets/error_actions.dart';
import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView(
    this.message, {
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return ErrorActions(message);
  }
}
