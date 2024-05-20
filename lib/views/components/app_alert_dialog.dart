import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.content,
    this.onPressed,
  });

  final void Function()? onPressed;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('Đóng'),
        ),
      ],
      contentPadding: const EdgeInsets.all(20),
      content: Text(content),
      backgroundColor: Colors.deepPurple.shade800,
    );
  }
}
