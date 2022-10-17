import 'package:biometric_login/shared/components/return_button.dart';
import 'package:biometric_login/shared/constants/theme.dart';
import 'package:flutter/material.dart';

class HelloView extends StatelessWidget {
  const HelloView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("You're logged in!!!"),
          ReturnButton()
        ],
      ),
    );
  }
}
