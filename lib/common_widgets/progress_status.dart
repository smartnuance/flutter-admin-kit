import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressStatus extends StatelessWidget {
  const ProgressStatus({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
            width: 30,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          if (message != null)
            Text(
              message!,
              style: Theme.of(context).textTheme.caption,
            )
        ],
      ),
    );
  }
}
