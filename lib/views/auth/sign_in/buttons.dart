import 'package:admin/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.text,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 16.0)),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      loading: loading,
      onPressed: onPressed,
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key? key,
    required this.text,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 16.0)),
      color: Theme.of(context).errorColor,
      textColor: Colors.white,
      loading: loading,
      onPressed: onPressed,
    );
  }
}
