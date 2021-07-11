import 'package:admin/common_widgets/error_actions.dart';
import 'package:admin/views/crud/api_service.dart';
import 'package:flutter/material.dart';

class PermissionDeniedView extends StatelessWidget {
  const PermissionDeniedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorActions(NotAuthorizedException());
  }
}
