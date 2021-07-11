import 'package:admin/common_widgets/loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends LoadingButton {
  FormSubmitButton({
    Key? key,
    required String text,
    bool loading = false,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          textColor: Colors.white,
          loading: loading,
          onPressed: onPressed,
        );
}
