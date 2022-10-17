import 'package:biometric_login/shared/components/rsb_button.dart';
import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RSBButton(
      text: 'Return',
      iconStart: Icons.keyboard_return,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}