import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
    required this.child,
    this.color,
    this.textColor,
    this.height = 40.0,
    this.borderRadius = 4.0,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final Color? textColor;
  final double height;
  final double borderRadius;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: loading
              ? SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white),
                    strokeWidth: 2.0,
                  ),
                )
              : child,
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const StadiumBorder(),
          textStyle: TextStyle(color: textColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
